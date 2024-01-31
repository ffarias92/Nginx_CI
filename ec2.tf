# Archivo ec2.tf

#Configuracion de la instancia 1

resource "aws_instance" "ec2_instance_1" {
  count   = 1
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.redes_privadas[0].id
  ami         = "ami-0a3c3a20c09d6f377"
  key_name    = "llaves-nginx"
  vpc_security_group_ids = [aws_security_group.http_outbound_sg.id]
  associate_public_ip_address = true

  tags = {
    Name     = "servidor-web-1"
    Terraform = "true"
    Environment = "dev"
  }

  availability_zone = "us-east-1a"

}

#Configuracion de la instancia 2

resource "aws_instance" "ec2_instance_2" {
  count   = 1
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.redes_privadas[1].id
  ami         = "ami-0a3c3a20c09d6f377"
  key_name    = "llaves-nginx"
  vpc_security_group_ids = [aws_security_group.http_outbound_sg.id]
  associate_public_ip_address = true


  tags = {
    Name     = "servidor-web-2"
    Terraform = "true"
    Environment = "dev"
  }

  availability_zone = "us-east-1b"
}


# Devuelve la IP de la primera instancia como output
output "ec2_instance_1_ip" {
  value = aws_instance.ec2_instance_1.*.public_ip
}

# Devuelve la IP de la segunda instancia como output

output "ec2_instance_2_ip" {
  value = aws_instance.ec2_instance_2.*.public_ip
}
