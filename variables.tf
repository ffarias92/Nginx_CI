# Archivo variables.tf

# Variables para las subredes y las zonas de disponibilidad
variable "cidr_blocks" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "cidr_general" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}


variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
