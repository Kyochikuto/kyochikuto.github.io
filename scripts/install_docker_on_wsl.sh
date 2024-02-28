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

echo "${GREEN}>> Fixing WSL2 Ubuntu 22.04 quirks ${DEFAULT}"
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

echo "${GREEN}>> Restarting Docker service ${DEFAULT}"
sudo service docker restart

echo "${GREEN}<<< Docker Installation Finished. >>>${DEFAULT}"
newgrp docker
