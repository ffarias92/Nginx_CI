# CoreDevX


Para ingresar  a las instancias Crear llave  con siguiente comando : 


<code> aws ec2 create-key-pair --key-name "llaves-nginx" --query 'KeyMaterial' --output text > "nombre-archivo".pem </code>


Para ejecutar la Infraestructura en AWS ejecutar la siguiente linea de comandos : 

<code> terraform init # para descargar las dependencias </code>

<code> terraform plan # para revisar la configuracion a ejecutar </code>

<code> terraform apply # para aplicar la configuracion de la infraestructura en AWS </code>


Para poder instalar Nginx en las instancias ejecutar el archivo nginx.sh 

<code> bash -x nginx.sh </code>


Definir Usuarios y contraseñas para base de datos RDS en un archivo con cualquier nombre de preferencia, (personalmente lo llame credenciales-database.tf)

'''plaintext
variable "database_username" {
  type    = string
  default = "$definir-usuario"
}


variable "database_password" {
  type    = string
  default = "$definir-contraseña"




luego ejecutar el siguiente comando :

<code> terraform apply -var-file=credentials.tfvars </code>


Revisar el DNS entregado por el ELB en el navegador

alb_dns_name =  "nombre DNS" 
