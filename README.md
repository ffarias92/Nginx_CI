# Nginx_CI


Para ingresar  a las instancias Crear llave  con siguiente comando : 


<code> aws ec2 create-key-pair --key-name "llaves-nginx" --query 'KeyMaterial' --output text > "nombre-archivo".pem </code>

Definir Usuarios y contraseñas para base de datos RDS en un archivo con cualquier nombre de preferencia, (personalmente lo llame credenciales-database.tf)

<code>variable "database_username" {
  type    = string
  default = "$definir-usuario"
}</code>

<code>variable "database_password" {
  type    = string
  default = "$definir-contraseña"
}</code>

Para ejecutar la Infraestructura en AWS ejecutar la siguiente linea de comandos : 

<code> terraform init # para descargar las dependencias </code>

<code> terraform plan # para revisar la configuracion a ejecutar </code>

<code> terraform apply # para aplicar la configuracion de la infraestructura en AWS </code>


Para poder instalar Nginx en las instancias ejecutar el archivo nginx.sh 

<code> bash -x nginx.sh </code>


Revisar el DNS entregado por ALB en el navegador

alb_dns_name =  "nombre DNS" 
