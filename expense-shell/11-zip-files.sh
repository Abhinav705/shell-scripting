#!/bin/bash

SOURCE_DIR=/tmp/shell-logs
DEST_DIR=/archive/shell-logs-zipped

if [ -d $SOURCE_DIR && -d $DEST_DIR ]
then
    echo "Source and dest directory exists"
else
    echo "Please check the directories"
    exit 1
fi