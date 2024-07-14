#!/bin/bash

SOURCE_DIR=/tmp/shell-logs
DEST_DIR=/archive/shell-logs-zipped
ZIPNAME=$DEST_DIR/old_files_archive.zip

if [ -d $SOURCE_DIR ] && [ -d $DEST_DIR ]
then
    echo "Source and dest directory exists"
else
    echo "Please check the directories"
    exit 1
fi

FILES=$(find $SOURCE_DIR "*.log" -mtime +14)

while IFS= read -r line
do
    zip -r "$ZIPNAME" "$line"

done <<<$FILES