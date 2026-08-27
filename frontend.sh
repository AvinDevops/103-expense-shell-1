

#configuring main steps
dnf install nginx -y &>>$LOGFILE
VALIDATE $? "Installing nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "Enabiling nginx"

systemctl start nginx &>>$LOGFILE
VALIDATE $? "Starting nginx service"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "Removing all files ins html dir"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading frontend zip file in tmp dir"

cd /usr/share/nginx/html &>>$LOGFILE
VALIDATE $? "Changing to html dir"

unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "Unzipping frontend zip file in html dir"

cp /home/ec2-user/102-expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copying expense.conf to default dir"

systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarting nginx service"