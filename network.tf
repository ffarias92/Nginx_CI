# Archivo network.tf

# Define una VPC
resource "aws_vpc" "my_vpc" {
  cidr_block             = "10.0.0.0/16"
  enable_dns_support     = true
  enable_dns_hostnames   = true
}

# Define subredes privadas
resource "aws_subnet" "redes_privadas" {
  count = 2
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.cidr_blocks, count.index)
  availability_zone = element(var.azs, count.index)
}

# Define una tabla de ruteo para subredes públicas
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Adjunta la tabla de ruteo a las subredes
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.redes_privadas[0].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.redes_privadas[1].id
  route_table_id = aws_route_table.public_route_table.id
}

# Crea un Internet Gateway para la VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Define un grupo de seguridad para RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds_security_group"
  description = "Allow inbound traffic to RDS"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define un grupo de subredes de base de datos RDS
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.redes_privadas[0].id, aws_subnet.redes_privadas[1].id]
  tags = {
    Name = "MyDBSubnetGroup"
  }
}

