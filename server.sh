#!/bin/bash
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
      echo -e "$1 \e[31mit's an invalid option"
      exit 1
   fi
}
 
echo -e "\e[32mStarting script, please wait ..."
 
CheckUser
if [ $? -ne "0" ]; then
   echo -e "nYou are not \e[31mroot, run as superuser!n"
   exit 1
fi
 

echo -e "\e[32mYou must enter one of the following parameters to perform the functions: "
echo -e "up"
echo -e "down"
read -p "Option: " op

CheckOptions $op
exit 1

#/usr/bin/clear
 
