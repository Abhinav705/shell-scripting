#!/bin/bash
userid=$(id -u)
DATETIMESTAMP=$(date +F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$DATETIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is  $R failed.. $N"
    else
        echo -e "$2 is $G SUCCESS $N"
    fi
}

if [ $userid -ne 0 ]
then
    echo -e "You are not $R SUPER $N user"
    exit 1
else
    echo -e "You are $R SUPER $N user"
fi

echo "Enter Password: "
read -s password

dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "Disbaling node js"

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "Enabling nodejs:20"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "Installing nodejs"

id expense &>>$LOG_FILE
if [ $? -ne 0 ]
then
    useradd expense &>>$LOG_FILE
    VALIDATE $? "Adding user expense"
else
    echo "User is already exists..SKIPPING"
fi

mkdir -p /app &>>$LOG_FILE

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG_FILE

cd /app

rm -rf /app/*
unzip /tmp/backend.zip &>>$LOG_FILE
VALIDATE $? "Unzipping completed"

cd /app
npm install &>>$LOG_FILE
VALIDATE $? "Installing dependencies"


cp /home/ec2-user/shell-scripting/expense-shell/backend.service  /etc/systemd/system/backend.service &>>$LOG_FILE
VALIDATE $? "Copied backend service"

systemctl daemon-reload &>>$LOG_FILE
systemctl start backend &>>$LOG_FILE
systemctl start backend &>>$LOG_FILE
dnf install mysql -y &>>$LOG_FILE
VALIDATE $? "Installing myssql client"

mysql -h 172.31.44.110 -uroot -p$password < /app/schema/backend.sql
VALIDATE $? "Loading Schema"

systemctl restart backend &>>$LOG_FILE
VALIDATE $? "Restarting backend"





