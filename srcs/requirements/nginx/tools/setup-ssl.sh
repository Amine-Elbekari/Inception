#!/bin/bash

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -days 365 -subj "/C=MA/L=Casablanca/O=1337/CN=localhost.42.fr";
echo "SSL for Nginx is set up succefully!";
fi

exec "$@"