#!/bin/bash

userid=$(id -u)
if [ $userid -ne 0 ]
then
    echo "Please get admin access"
    exit 1
else
    echo "you have admin access"
fi

dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "Installation failed"
    exit 1
else
    echo "Installation Success"
fi

dnf install git -y

if [ $? -ne 0 ]
then
    echo "Installation failed"
    exit 1
else
    echo "Installation Success"
fi

echo "Script completed successfully"
