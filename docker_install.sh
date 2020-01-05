#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function HasDocker () {
    HAS_DOCKER=$(docker -v)
    return $HAS_DOCKER
}

function InstallDocker () {
    echo -e "${GREEN}Install docker${NC}"
    echo -e "${GREEN}Update system${NC}"
    sudo apt-get update && sudo apt-get upgrade
    echo -e "${GREEN}Preparate dependences${NC}"
    sudo apt install curl -y
    echo -e "${GREEN}Download script${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    echo -e "${GREEN}Exec script${NC}"
    sh get-docker.sh
    echo -e "${GREEN}Test Instalation${NC}"
    echo $(docker version)
}

function HasDockerCompose() {
    HAS_DOCKER_COMPOSE=$(docker-compose --version)
    return $HAS_DOCKER_COMPOSE
}

function RemoveOlderVersions() {
    echo -e "${GREEN}Remove Older versions${NC}"
    sudo apt-get remove docker-compose
    sudo rm /usr/local/bin/docker-compose
    #pip uninstall docker-compose
}

function InstallDockerCompose() {
    #remove if not latest
    VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
    DESTINATION=/usr/local/bin/docker-compose
    sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
    sudo chmod 755 $DESTINATION
    echo -e "${GREEN}Verify docker-compose version${NC}"
    echo $(docker-compose --version)
}

HasDocker
if [ $? -ne "0" ]; then
    echo -e "${GREEN}Not has Docker${NC}"
    InstallDocker
fi

HasDockerCompose
if [ $? -ne "0" ]; then
    echo -e "${GREEN}Not has docker-compose${NC}"
    InstallDockerCompose
fi
