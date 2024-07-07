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
    else
        echo -e "installation of $2 is $G success $G"
    fi
}

if [ $userid -ne 0 ]
then
    echo -e "You don't have root access. Please get the $R root $N access"
    exit 1
else
    echo -e "You have the $G root $N access"
fi

for i in $@
do
    echo "Checking the package $i is present or not...."
    dnf list installed $i &>>$LOG_FILE
    if [ $? -eq 0 ]
    then
        echo -e "Package $i is already installed...$Y skipping $N"
    else
        dnf install $i -y >>$LOG_FILE
        VALIDATE $? "Installation of $i"
    fi
done