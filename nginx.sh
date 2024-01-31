#!/bin/bash

# Función para manejar errores
handle_error() {
    echo "Error: $1"
    exit 1
}

# Ejecuta el outputs.json y deja como variable cada una de las dos IP
OUTPUTS_FILE="outputs.json"
EC2_INSTANCE_1_IP=$(jq -r '.ec2_instance_1_ip.value[0]' $OUTPUTS_FILE) || handle_error "No se pudo obtener la IP de la instancia 1"
EC2_INSTANCE_2_IP=$(jq -r '.ec2_instance_2_ip.value[0]' $OUTPUTS_FILE) || handle_error "No se pudo obtener la IP de la instancia 2"

# Avisa el paso para conectarse a la primera instancia e instala nginx dejando el nombre del hostname
echo "Conectando a la instancia 1 en $EC2_INSTANCE_1_IP"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_1_IP "sudo yum update -y && sudo yum install -y nginx" || handle_error "Error al instalar Nginx en la instancia 1"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_1_IP "echo 'Instancia 1 - $EC2_INSTANCE_1_IP' | sudo tee /usr/share/nginx/html/index.html" || handle_error "Error al escribir en el archivo index.html en la instancia 1"

# Avisa el paso para conectarse a la segunda instancia e instala nginx dejando el nombre del hostname
echo "Conectando a la instancia 2 en $EC2_INSTANCE_2_IP"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_2_IP "sudo yum update -y && sudo yum install -y nginx" || handle_error "Error al instalar Nginx en la instancia 2"
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y -n -i llaves-nginx.pem ec2-user@$EC2_INSTANCE_2_IP "echo 'Instancia 2 - $EC2_INSTANCE_2_IP' | sudo tee /usr/share/nginx/html/index.html" || handle_error "Error al escribir en el archivo index.html en la instancia 2"

echo "Tareas completadas exitosamente"

