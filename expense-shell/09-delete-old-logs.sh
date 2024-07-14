SOURCE_DIR=/tmp/shell-logs

if [ -d $SOURCE_DIR ]
then
    echo "Source Directory exists"
else
    echo "Source Directory doesn't exists"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +14)

while IFS=read -r line
do
    echo "Deleting the file : $line"
    rm -rf $line
done <<<$FILES
