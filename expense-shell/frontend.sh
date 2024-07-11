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

dnf install nginx -y &>>$LOG_FILE
VALIDATE $? "Installing nginx"
systemctl enable nginx &>>$LOG_FILE
VALIDATE $? "Enabling nginx"
systemctl start nginx &>>$LOG_FILE
VALIDATE $? "Starting nginx"

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
VALIDATE $? "Removing default html"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOG_FILE
VALIDATE $? "Downloading frontend code"

cd /usr/share/nginx/html &>>$LOG_FILE
unzip /tmp/frontend.zip &>>$LOG_FILE
VALIDATE $? "Unzipping frontend code"

cp /home/ec2-user/shell-scripting/expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copied expense conf"

systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarting nginx"
