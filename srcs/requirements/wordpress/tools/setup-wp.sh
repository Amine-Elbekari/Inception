#!/bin/bash

awk '/listen = \/run\/php\/php7.4-fpm.sock/ { $0 = "listen = 9000" } 1' "/etc/php/7.4/fpm/pool.d/www.conf" > "/etc/php/7.4/fpm/pool.d/www.conf.tmp"
mv "/etc/php/7.4/fpm/pool.d/www.conf.tmp" "/etc/php/7.4/fpm/pool.d/www.conf"



mkdir -p /run/php/
touch /run/php/php7.4-fpm.pid

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "🚀 Setting up WordPress..."
    mkdir -p /var/www/html
    if [ ! -f /usr/local/bin/wp ]; then
        # wget https://wordpress.org/wordpress-6.2.2.tar.gz 
        # tar -xvzf wordpress-6.2.2.tar.gz -C var/www/html/
        wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
        chmod +x wp-cli.phar
        mv wp-cli.phar /usr/local/bin/wp
        echo "WP-CLI installed.🛠️"
    else
        echo "WP-CLI is already installed. 🚗"
    fi
    
    cd /var/www/html
    chown -R www-data:www-data /var/www/*
    chmod -R 755 /var/www/*

    wp core download --allow-root

    #mv /var/www/wp-config.php /var/www/html/
    
     awk -v db_name="$DB_NAME" -v db_user="$DB_USER" -v db_password="$DB_PASSWORD" -v db_host="$DB_HOST" -v db_charset="$DB_CHARSET" \
        '{ gsub(/database_name_here/, db_name); gsub(/username_here/, db_user); gsub(/password_here/, db_password); gsub(/localhost/, db_host); gsub(/utf8/, db_charset); print }' \
        wp-config-sample.php > wp-config.php

    echo "👩‍💻 Creating Wordpress Users ... 👩‍💻"
    wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}
    wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD}

    echo "✅ WordPress has been successfully set up .🎉"
else
    echo "Wordpress: wp-config.php already exist. Skipping setup."
fi

exec "$@"