#!/bin/sh

addgroup -g 82 -S www-data; \

mkdir -p var/www/html

#create users for php and nginx
adduser -D -g 'www-data' www-data

#setting up nginx webserver user permissions to directories
mkdir -p /usr/local/etc/php/conf.d; 
mkdir -p /var/www/html;
chown -R www-data:www-data /var/www/html;
chmod 777 /var/www/html
chown -R www-data:www-data /var/lib/nginx

mkdir -p /run/openrc/
touch /run/openrc/softlevel
sed -i 's/#cgi.fix_pathinfo=1/#cgi.fix_pathinfo=0/' /etc/php7/php.ini
openrc
rc-service php-fpm7 start
nginx
nginx -g "daemon off;"
