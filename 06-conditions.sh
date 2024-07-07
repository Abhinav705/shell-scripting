#!/bin/bash

userid=$(id -u)
if [$userid -ne 0]
then
    echo "Please get admin access"
    exit 1
else
    echo "you have admin access"
fi

dnf install mysql -y