#!/bin/bash

# Install dependancies
apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg2
# Download the package from docker
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
# Update repository
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Installation of Docker-Compose
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# Setup Permission
chmod +x /usr/local/bin/docker-compose

# Add our main user ( if set ) to the docker group because I don't want to sign in as ADMIN
if [ ! -z "$INSTALL_USER" ]; then
    groupadd docker
    gpasswd -a "$INSTALL_USER" docker
fi