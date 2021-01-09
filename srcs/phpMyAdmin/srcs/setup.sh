#!/bin/sh

mkdir -p /run/openrc/ /var/www/html/tmp
chmod 777 /var/www/html/tmp
touch /run/openrc/softlevel
openrc
rc-service nginx start
rc-service nginx stop
rc-service php-fpm7 start
cp /var/www/html/config.sample.inc.php /var/www/html/config.inc.php
sed -ri -e 's/localhost/'$MYSQL_SERVICE_PORT_3306_TCP_ADDR'/' /var/www/html/config.inc.php
rand=`tr -dc 'a-zA-Z0-9~!@#$%^&*_()+}{?></";.,[]=-' < /dev/urandom | fold -w 32 | head -n 1`
sed -ri -e "s/blowfish_secret.*/blowfish_secret\'\] = \'$rand\'\;/g" /var/www/html/config.inc.php
echo "\$cfg['TempDir'] = '/var/www/html/tmp';" >> /var/www/html/config.inc.php
rc-service php-fpm7 restart
nginx -g "daemon off;"
