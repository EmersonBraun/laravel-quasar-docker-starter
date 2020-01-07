#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

DIRECTORY=$(pwd)

function CheckUser () {
   USER_ID=$(/usr/bin/id -u)
   if [ $? -ne "0" ]; then
        echo -e "${RED}You are not root, run as superuser!${NC}"
        exit 1
    fi
}

function CheckDocker () {
    echo -e "${GREEN}give permission to files${NC}"
    chmod +x ./devops/instalations/docker_install.sh
    chmod +x server.sh
    bash ./devops/instalations/docker_install.sh
}

function VerifyBackend(){
    if [ ! -e "$DIRECTORY/backend/vendor" ]; then
        InitBackend
    fi
}

function InitBackend() {
    cd "$DIRECTORY/backend/"
    echo -e "${GREEN}give permission to files${NC}"
    chmod -R 775 storage
    chmod -R 775 bootstrap/cache
    cp env.example .env

    docker-compose run web bash -c "composer update"
    docker-compose run web bash -c "php artisan key:generate"
}

function VerifyFrontend(){
    if [ ! -e "$PWD/frontend/node_modules" ]; then
        InitFrontend
    fi
}

function InitFrontend() {
    cd "$DIRECTORY/frontend/"
    docker-compose run app bash -c "yarn install"
}

function UpServer() {
    bash ./server.sh up
}

CheckUser
CheckDocker
UpServer
VerifyBackend
VerifyFrontend
