#!/bin/bash

#prepare openrc run dir
if [ ! -d "/run/openrc/" ]; then
  mkdir -p /run/openrc/
  touch /run/openrc/softlevel
  openrc
fi

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
fi

/etc/init.d/mariadb setup

if [ -d /app/mysql ]; then
	echo "MySQL directory already present, skipping creation"
else
	echo "MySQL data directory not found, creating initial DatabasesBs"

	mysql_install_db --user=root > /dev/null

	if	[ "$MYSQL_ROOT_PASSWORD" = "" ]; then
		MYSQL_ROOT_PASSWORD=toor
		echo "MySQL root Password: $MYSQL_ROOT_PASSWORD"
  fi

	MYSQL_DATABASE=${MYSQL_DATABASE:-""}
	MYSQL_USER=${MYSQL_USER:-""}
	MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}

	tempfile=`mktemp` #create a temporary file
	if [ ! -f "$tempfile" ]; then
	  return 1
	fi

	#applying root new permissions
	cat << EOF > $tempfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$MYSQL_ROOT_PASSWORD" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
EOF

	# creating database
	if [ "$MYSQL_DATABASE" != "" ]; then
	echo "Creating database: $MYSQL_DATABASE"
	echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tempfile

	#creating user
	if [ "$MYSQL_USER" != "" ]; then
	  echo "Creating user: $MYSQL_USER with password $MYSQL_PASSWORD"
	  echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tempfile
	fi
	fi
	mkdir -p /app/mysql
	# apply everything on the sql script file and delete it
	/usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tempfile
	rm -f $tempfile
fi
rc-service mariadb restart
rc-service mariadb stop

sh /telegraf.sh
(/usr/bin/mysqld --user=root --console &) && ( /telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &)

mkdir /liveness
touch /liveness/live

while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "/telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf" ; [ $? -eq 1 ] && touch /liveness/teleg_
cat /liveness/processes | grep "mysql"; [ $? -eq 1 ] && touch /liveness/mysql_
if [ ! -f /liveness/mysql_ -o ! -f /liveness/teleg_ ]; then
    rm /liveness/live
fi
sleep 5
done
