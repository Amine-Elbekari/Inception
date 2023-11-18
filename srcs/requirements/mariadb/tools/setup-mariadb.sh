#!/bin/bash

service mariadb start

sleep 2

mysql -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"

mysql -u root  -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"

mysql -u root  -e "FLUSH PRIVILEGES;" 


service mariadb stop
sleep 2
mysqld_safe
