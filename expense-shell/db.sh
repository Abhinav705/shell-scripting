#!/bin/bash
$userid=$(id -u)
$DATETIMESTAMP=$(date +F-%H-%M-%S)
$SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
$LOG_FILE=/tmp/$SCRIPT_NAME-$DATETIMESTAMP.log
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

SUPERUSER(){
    if [ $userid -ne 0 ]
    then
        echo -e "You are not $R SUPER $N user"
    else
        echo -e "You are $R SUPER $N user"
    fi
}

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "SQL Server installation"

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "Enabling enabling mysql"

systemctl start mysqld &>>$LOG_FILE
VALIDATE $? "Starting MYSQL"


mysql -h 172.31.44.110 -uroot -pExpenseApp@1 -e 'show databases;' &>>$LOG_FILE

if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG_FILE
    VALIDATE $? "Setting up password.."
else
    echo -e "Password already set..$Y Skipping.. $N"
fi





