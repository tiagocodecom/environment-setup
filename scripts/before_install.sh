#!/bin/bash

set -euo pipefail

echo "-----------------------------------------------------"
echo "[ENV-TIAGOCODE.COM] hook: BeforeInstall"
echo "-----------------------------------------------------"

# Install Docker & Docker Compose plugin
sudo dnf install docker -y
sudo service docker start
sudo usermod -aG docker ec2-user
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose --version


# Login into Github Container Regitry
GITHUB_PAT=$(aws ssm get-parameter --name "/tiagocode/ghcr/pat" --with-decryption --query "Parameter.Value" --output text)
echo "$GITHUB_PAT" | docker login ghcr.io -u "smarulanda97" --password-stdin
