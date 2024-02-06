#!/bin/bash

# Crear el archivo variables_database.tf
touch variables_database.tf

# Escribir las definiciones de variables en el archivo
echo '
variable "database_username" {
  type    = string
  default = "usuario1"
}

variable "database_password" {
  type    = string
  default = "contraseña1"
}
' > variables_database.tf

# Dar formato al archivo con terraform fmt
terraform fmt variables_database.tf

