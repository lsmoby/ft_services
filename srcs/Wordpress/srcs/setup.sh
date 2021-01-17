#!/bin/bash

mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc
rc-service php-fpm7 start
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

set_config() {
sed -ri -e "s/(define\(\s*'$1',\s*['\"])(.*)([\'\"]\s*\);)/\1$2\3/" /var/www/html/wp-config.php
    }

set_config 'DB_HOST' "$MYSQL_SERVICE_PORT_3306_TCP_ADDR"
set_config 'DB_USER' "$WORDPRESS_DB_USER"
set_config 'DB_PASSWORD' "$WORDPRESS_DB_PASSWORD"
set_config 'DB_NAME' "$WORDPRESS_DB_NAME"

set_config 'AUTH_KEY' "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
set_config 'SECURE_AUTH_KEY' "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
set_config 'LOGGED_IN_KEY' "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
set_config 'NONCE_KEY' "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
set_config 'AUTH_SALT' "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
set_config 'SECURE_AUTH_SALT' "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
set_config 'LOGGED_IN_SALT' "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
set_config 'NONCE_SALT' "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"

sh /telegraf.sh
(nginx -g "daemon off;" &) && ( /telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &)
mkdir /liveness
touch /liveness/live
while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "/telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf" ; [ $? -eq 1 ] && touch /liveness/teleg_
cat /liveness/processes | grep "nginx"; [ $? -eq 1 ] && touch /liveness/nginx_
cat /liveness/processes | grep "php"; [ $? -eq 1 ] && touch /liveness/php_
if [ ! -f /liveness/teleg_ -o ! -f /liveness/nginx_ -o ! -f /liveness/php_]; then
    rm /liveness/live
fi
sleep 5
done
