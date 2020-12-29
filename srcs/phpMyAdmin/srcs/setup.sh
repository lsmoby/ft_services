#!/bin/sh

mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc
rc-service nginx start
rc-service nginx stop
rc-service php-fpm7 start
cp /var/www/html/config.sample.inc.php /var/www/html/config.inc.php
sed -i 's/$cfg['Servers'][$i]['host'] = 'localhost';/$cfg['Servers'][$i]['host'] = '$MYSQL_SERVICE_PORT_3306_TCP_ADDR';/' /var/www/html/config.inc.php
rc-service php-fpm7 restart
nginx -g "daemon off;"
