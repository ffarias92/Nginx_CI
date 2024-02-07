# Archivo alb.tf

#

# Definición del grupo de destino
resource "aws_lb_target_group" "nginx" {
  name        = "nginx"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "instance"
  health_check {
    port = 80
    path = "/"
  }
}

# Definición del balanceador de carga
resource "aws_lb" "nginx" {
  name               = "balanceador-Nginx"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.redes_privadas[0].id, aws_subnet.redes_privadas[1].id]
  security_groups    = [aws_security_group.http_outbound_sg.id]
  depends_on         = [aws_lb_target_group.nginx]
}

# Asocia ambas instancias EC2 al balanceador de Carga ALB
resource "aws_lb_target_group_attachment" "nginx_attachment_1" {
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id       = aws_instance.ec2_instance_1[0].id
}

resource "aws_lb_target_group_attachment" "nginx_attachment_2" {
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id       = aws_instance.ec2_instance_2[0].id
}

# Agregar una regla de escucha para redirigir el tráfico HTTP al grupo de destino "nginx" el cual realiza el balanceo de carga
resource "aws_lb_listener_rule" "nginx_listener_rule" {
  listener_arn = aws_lb_listener.nginx_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  condition {
    host_header {
      values = ["example.com"]
    }
  }
}

# Agregar un agente de escucha para el puerto 80
resource "aws_lb_listener" "nginx_listener" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }
}

# Output para el DNS del ALB
output "alb_dns_name" {
  value = aws_lb.nginx.dns_name

}


