#!/bin/sh

# Colors
GREEN='\033[0;32m'
DEFAULT='\033[0m' # No Color

sudo rm /etc/apt/keyrings/docker.gpg
sudo rm /etc/apt/sources.list.d/docker.list

# Install Docker
echo "${GREEN}>>> Installing Pre-requisites ${DEFAULT}"
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "${GREEN}>>> Temporarily setting the DNS resolver to 403.online ${DEFAULT}"
sudo cp /etc/resolv.conf /etc/resolv.conf.backup
echo "nameserver 10.202.10.202" | sudo tee -a /etc/resolv.conf
sudo systemctl reload-or-restart systemd-resolved

echo "${GREEN}>>> Adding Docker GPG keys ${DEFAULT}"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "${GREEN}>>> Setting up repositories ${DEFAULT}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

echo "${GREEN}>>> Installing Docker from official repository ${DEFAULT}"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "${GREEN}>>> Enabling user permissions ${DEFAULT}"
sudo usermod -aG docker $(whoami)
sudo systemctl daemon-reload
sudo systemctl enable --now docker
sudo systemctl enable --now containerd

# echo "${GREEN}>>> Reverting the DNS resolver to original values ${DEFAULT}"
# sudo rm /etc/resolv.conf
# sudo mv /etc/resolv.conf.backup /etc/resolv.conf
# sudo systemctl reload-or-restart systemd-resolved

echo "${GREEN}<<< Docker Installation Finished. >>>${DEFAULT}"
newgrp docker
