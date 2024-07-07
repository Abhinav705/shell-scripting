#!/bin/bash

userid=$(id -u)
DATETIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$DATETIMESTAMP.log

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "installation of $2 is failed"
        exit 1
    else
        echo "installation of $2 is success"
    fi

}

if [ $userid -ne 0 ]
then
    echo "Please get admin access"
    exit 1
else
    echo "you have admin access"
fi

dnf install mysql -y &&>>$LOG_FILE
VALIDATE $? "installing mysql"