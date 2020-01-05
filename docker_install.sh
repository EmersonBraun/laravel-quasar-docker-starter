#!/bin/bash
#install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
#Install docker-compose
sudo apt-get remove docker-compose
sudo rm /usr/local/bin/docker-compose
pip uninstall docker-compose
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
DESTINATION=/usr/local/bin/docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod 755 $DESTINATION
echo $(docker-compose --version)