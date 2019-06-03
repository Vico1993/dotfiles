#!/bin/bash

#Check if it's execute as ROOT
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

# Set up the main user ( usefull for linux environement )
export INSTALL_USER="victor"

# execute all installation files in ./bin directory
for file in ./bin/*.sh; do
	# Check if this file is readable
	if [[ -r "$file" ]]; then
		bash $file
	else
		echo "IMPOSSIBLE TO EXECUTE $file"
	fi
done

apt update -y
apt-get -y upgrade

apt-get install -y git docker-ce

git config --global user.name "Victor Piolin"
git config --global user.email victor.piolin@gmail.com
