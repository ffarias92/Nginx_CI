#!/bin/bash

#terraform output para extraer los output - en este caso las ips de las dos instancias

terraform output -json > outputs.json

# Se crea  Función para manejar errores
handle_error() {
    echo "Error: $1"
    exit 1
}

# Toma las IP de las instancias desde el archivo outputs.json 
OUTPUTS_FILE="outputs.json"
EC2_INSTANCE_1_IP=$(jq -r '.ec2_instance_1_ip.value[0]' $OUTPUTS_FILE)
EC2_INSTANCE_2_IP=$(jq -r '.ec2_instance_2_ip.value[0]' $OUTPUTS_FILE)

# Avisa el paso para conectarse a la primera instancia e instala nginx, se deja para que inicie con la maquina y se ejecuta el servicio
echo "Conectando a la instancia 1 en $EC2_INSTANCE_1_IP"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_1_IP "sudo yum update -y && sudo yum install nginx -y" || handle_error "Error al instalar Nginx en la instancia 1"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_1_IP "echo 'Instancia 1 - $EC2_INSTANCE_1_IP' | sudo tee /usr/share/nginx/html/index.html"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_1_IP "sudo systemctl enable nginx && sudo systemctl start nginx"



# Avisa el paso para conectarse a la segunda instancia e instala nginx, se deja para que inicie con la maquina y se ejecuta el servicio
echo "Conectando a la instancia 2 en $EC2_INSTANCE_2_IP"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_2_IP "sudo yum update -y && sudo yum install nginx -y" || handle_error "Error al instalar Nginx en la instancia 2"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_2_IP "echo 'Instancia 2 - $EC2_INSTANCE_2_IP' | sudo tee /usr/share/nginx/html/index.html" || handle_error "Error al escribir en el archivo index.html en la instancia 2"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_2_IP "sudo systemctl enable nginx && sudo systemctl start nginx"

echo "Tareas completadas exitosamente"
