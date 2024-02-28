#!/bin/sh

# Colors
GREEN='\033[0;32m'
DEFAULT='\033[0m' # No Color

echo "${GREEN}### Adding proxy settings for Docker...\n  ${DEFAULT}"
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo touch /etc/systemd/system/docker.service.d/http-proxy.conf
sudo sh -c 'echo "[Service]
Environment=\"HTTP_PROXY=http://127.0.0.1:3128\"
Environment=\"HTTPS_PROXY=http://127.0.0.1:3128\"
Environment=\"NO_PROXY=localhost,127.0.0.1,192.168.*,dockerhub.ir\"" > /etc/systemd/system/docker.service.d/http-proxy.conf'

sudo touch /etc/apt/apt.conf.d/99proxy
sudo sh -c 'echo "
Acquire::http::proxy::download.docker.com \"http://127.0.0.1:3128\";
Acquire::https::proxy::download.docker.com \"http://127.0.0.1:3128\";
" > /etc/apt/apt.conf.d/99proxy'

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl restart containerd

echo "${GREEN}### Finished! \n  ${DEFAULT}"
