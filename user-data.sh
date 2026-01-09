#!/bin/bash
set -e

# Atualiza o sistema
dnf update -y

# Instala Docker
dnf install -y docker

# Inicia Docker
systemctl start docker
systemctl enable docker

# Aguarda Docker subir
sleep 10

# Login no ECR (usa IAM Role da EC2)
aws ecr get-login-password --region sa-east-1 \
| docker login --username AWS --password-stdin 563840908987.dkr.ecr.sa-east-1.amazonaws.com

# Pull da imagem
docker pull 563840908987.dkr.ecr.sa-east-1.amazonaws.com/hello-aws:latest

# Remove container antigo se existir
docker rm -f hello-ecr || true

# Sobe o container
docker run -d -p 80:80 --name hello-ecr \
563840908987.dkr.ecr.sa-east-1.amazonaws.com/hello-aws:latest
