#!/bin/bash

mkdir -p /run/openrc/ /var/www/html/tmp
chmod 777 /var/www/html/tmp
touch /run/openrc/softlevel
openrc
rc-service nginx start
rc-service nginx stop
rc-service php-fpm7 start
cp /var/www/html/config.sample.inc.php /var/www/html/config.inc.php
sed -ri -e 's/localhost/'$MYSQL_SERVICE_PORT_3306_TCP_ADDR'/' /var/www/html/config.inc.php
rand="$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
sed -ri -e "s/blowfish_secret.*/blowfish_secret\'\] = \'$rand\'\;/g" /var/www/html/config.inc.php
echo "\$cfg['TempDir'] = '/var/www/html/tmp';" >> /var/www/html/config.inc.php
rc-service php-fpm7 restart

(nginx -g "daemon off;" &)

mkdir /liveness
touch /liveness/live

while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "nginx"; [ $? -eq 1 ] && touch /liveness/nginx_
cat /liveness/processes | grep "php"; [ $? -eq 1 ] && touch /liveness/php_
if [ ! -f /liveness/teleg_ -o ! -f /liveness/nginx_ -o ! -f /liveness/php_ ]; then
    rm /liveness/live
fi
sleep 5
done
