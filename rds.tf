# Archivo rds.tf

# Define una instancia de base de datos RDS para PostgreSQL
resource "aws_db_instance" "rds-postgres-1" {
  identifier             = "rds-postgres-1"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "13.7"
  instance_class         = "db.t3.micro"
  username               = "myadmin"
  password               = "mypassword"
  parameter_group_name   = "default.postgres13"
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
}
