#!/bin/sh

mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc
rc-service nginx start
rc-service nginx stop
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

nginx -g "daemon off;"
