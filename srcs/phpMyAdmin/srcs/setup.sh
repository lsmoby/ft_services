#!/bin/bash

mkdir -p /run/openrc/ /var/www/html/tmp
chmod 777 /var/www/html/tmp
touch /run/openrc/softlevel
openrc

cp /var/www/html/config.sample.inc.php /var/www/html/config.inc.php
sed -ri -e 's/localhost/'$MYSQL_SERVICE_PORT_3306_TCP_ADDR'/' /var/www/html/config.inc.php
rand="$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
sed -ri -e "s/blowfish_secret.*/blowfish_secret\'\] = \'$rand\'\;/g" /var/www/html/config.inc.php
echo "\$cfg['TempDir'] = '/var/www/html/tmp';" >> /var/www/html/config.inc.php

rc-service php-fpm7 start
rc-service nginx start
(nginx -g "daemon off;" &)

while true;	do
sleep 5
ret1="$(ps | grep php | grep -vc grep)"
ret2="$(ps | grep nginx | grep -vc grep)"
if [ $ret1 -eq 0 -o $ret2 -eq 0 ]; then
    echo "pod is unhealthy"
    break ;
else
    echo "pod is healthy"
fi
done
