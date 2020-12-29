#!/bin/sh


mkdir -p /run/openrc/
touch /run/openrc/softlevel
openrc
rc-service nginx start
rc-service nginx stop
rc-service php-fpm7 start
#sed -i 's/#cgi.fix_pathinfo=1/#cgi.fix_pathinfo=0/' /etc/php7/php.ini
rc-service php-fpm7 restart
nginx -g "daemon off;"
