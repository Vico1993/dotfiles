#!/bin/bash

#Check if it's execute as ROOT
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

#SETUP My own profile
cp .bash_profile /home/victor/.bash_profile

echo "Installing package"

# -- DOCKER PART
apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg2
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

groupadd docker
gpasswd -a "victor" docker

curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# -- DOCKER PART END

# GOLANG PART
export GO_VERSION
GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text")
export GO_SRC=/usr/local/go

GO_VERSION=${GO_VERSION#go}

(
	kernel=$(uname -s | tr '[:upper:]' '[:lower:]')
	curl -sSL "https://storage.googleapis.com/golang/go${GO_VERSION}.${kernel}-amd64.tar.gz" | tar -v -C /usr/local -xz
	# rebuild stdlib for faster builds
	chown -R "victor" /usr/local/go/pkg
	CGO_ENABLED=0 go install -a -installsuffix cgo std
)

# GOLANG PART END

apt update -y
apt-get -y upgrade

apt-get install -y git docker-ce

echo "Done installing package"