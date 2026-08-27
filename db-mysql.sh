#!/bin/bash

source ./common.sh

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing mysql"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabiling mysql"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting mysql"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "Setting password for root"
mysql -h db.aviexpense.online -uroot -pExpenseApp@1 -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
    VALIDATE $? "Setting password for root"
else
    echo -e "Password for mysql root user already set...$Y SKIPPING $N"
fi
