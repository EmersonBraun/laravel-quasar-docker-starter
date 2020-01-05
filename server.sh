#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function CheckUser () {
   USER_ID=$(/usr/bin/id -u)
   return $USER_ID
}
 
function UpServer () {
   cd backend/
   docker-compose up -d
   cd ..
   cd frontend/
   docker-compose up -d
}
 
function DownServer () {
   cd backend/
   docker-compose down
   cd ..
   cd frontend/
   docker-compose down
}
  
function CheckOptions () {
   if [ $1 = "up" ]; then
      UpServer
   elif [ $1 = "down" ]; then
      DownServer
   else
      echo -e "$1 ${RED}it's an invalid option${NC}"
      exit 1
   fi
}
 
echo -e "\e[32mStarting script, please wait ..."
 
CheckUser
if [ $? -ne "0" ]; then
   echo -e "${RED}You are not root, run as superuser!${NC}"
   exit 1
fi

CheckOptions $1
#/usr/bin/clear
 
