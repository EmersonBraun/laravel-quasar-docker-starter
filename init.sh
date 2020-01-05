#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function CheckUser () {
   USER_ID=$(/usr/bin/id -u)
   if [ $? -ne "0" ]; then
        echo -e "${RED}You are not root, run as superuser!${NC}"
        exit 1
    fi
}

function Permission () {
    echo -e "${GREEN}give permission to files${NC}"
    chmod +x docker_install.sh
    chmod +x server.sh
}

function VerifyBackend(){
    if [ ! -e "$PWD/backend/vendor" ]; then
        InitBackend
    fi
}

function InitBackend() {
    echo -e "${GREEN}give permission to files${NC}"
    chmod -R 775 storage
    chmod -R 775 bootstrap/cache
    cp env.example .env

    composer update
    php artisan key:generate
}

function VerifyFrontend(){
    if [ ! -e "$PWD/frontend/node_modules" ]; then
        InitFrontend
    fi
}

function InitFrontend() {
    npm install

}

CheckUser
Permission
VerifyBackend
VerifyFrontend

#verify docker and docker-compose instalation
bash ./docker_install
#up server
bash ./server.sh up
