# Archivo rds.tf

# Define una instancia de base de datos RDS para PostgreSQL
resource "aws_db_instance" "rds-postgres-1" {
  identifier             = "rds-postgres-1"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "15.5"
  instance_class         = "db.t3.micro"
  username               = var.database_username
  password               = var.database_password
  parameter_group_name   = "default.postgres15"
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
}
