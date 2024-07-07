#!/bin/bash

userid=$(id -u)

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

dnf install mysql -y
VALIDATE $? "installing mysql"