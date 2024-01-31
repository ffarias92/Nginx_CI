# CoreDevX


Para ingresar  a las instancias Crear llave  con siguiente comando : 


<code> aws ec2 create-key-pair --key-name "llaves-nginx" --query 'KeyMaterial' --output text > "nombre-archivo".pem </code>

Para poder instalar Nginx en las instancias ejecutar el archivo nginx.sh 

<code> bash -x nginx.sh </code>
