#!/bin/bash

sudo apt update
sudo apt install nginx -y

cd /var/www/html/

for i in {1..3}; do
	filename="page${i}.html"
	sudo touch "$filename"
	echo "Created '$filename'"

	echo "______________________________________________"
	sudo chown www-data:www-data "$filename"
	echo "Owner changed !!!"
	echo "_______________________________________________"
	sudo chmod 644 "$filename"
	echo "Permissions 644 for file doen"
	echo "_______________________________________________"
done

echo "Files created successfully."
echo "_______________________________________________"
echo "verifying permissions:"

ls -la page*.html

echo "________________________________________________"

if systemctl is-active --quiet nginx; then
	echo "Nginc is active !!!"

	sudo systemctl restart nginx
else
	echo "Nginx is down !!! Starting in progress"

	sudo systemctl start nginx
fi

echo "______________Status__________________"

sudo systemctl status nginx --no-pager | grep "Active:" 

echo "_____________Journal___________________"

sudo journalctl -u nginx -n 5 --no-pager
