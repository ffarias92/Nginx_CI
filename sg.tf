# Archivo sg.tf

# Definición del grupo de seguridad
resource "aws_security_group" "http_outbound_sg" {
  name        = "Security group HTTP"
  description = "Permitir acceso a Nginx y SSH"
  vpc_id      = aws_vpc.my_vpc.id
  tags = {
    Name = "Nginx"
  }


# Reglas de salida para Nginx HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr_general
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr_general
  }


# Reglas de Entrada y salida para HTTPS

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.cidr_general
  }


# Regla de entrada para SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks =  var.cidr_general
  }


#Reglas de entrada y salida para PostgreSQL

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks  #llama la variable cidr_blocks del archivo variables.tf
  }

}
