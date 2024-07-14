#!/bin/bash

DISK_MEM=$(df -hT | grep xfs)
LIMIT=5
Message=""

while IFS= read -r line
do
    PERCENTAGE=$(echo $line | awk -F " " '{print $6F}'| cut -d "%" -f1)
    FOLDER=$(echo $line| awk -F " " '{print $NF}')
    if [ $PERCENTAGE -ge $LIMIT ]
    then
        Message+="Disk Usage reached the limit: Folder is : $FOLDER and current usage is: $PERCENTAGE\n"
    fi
done <<<$DISK_MEM
echo -e  "Message : $Message"