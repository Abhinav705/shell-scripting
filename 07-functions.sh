#!/bin/bash

userid=$(id -u)
DATETIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$DATETIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "installation of $2 is $R failed $N"
        exit 1
    else
        echo -e "installation of $2 is $G success $N"
    fi

}

if [ $userid -ne 0 ]
then
    echo "Please get admin access"
    exit 1
else
    echo "you have admin access"
fi

dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "installing mysql"