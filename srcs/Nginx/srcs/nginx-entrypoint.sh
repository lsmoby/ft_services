#!/bin/sh

if [ ! -f /etc/ssl/certs/key.key -o ! -f /etc/ssl/certs/cer.crt ]; then
	# generate fresh ssl certificate and private key
	mkdir -p /etc/ssl/certs/
	openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/certs/key.key -x509 -days 365 -out /etc/ssl/certs/cer.crt -subj "/C=MA/ST=BENGUERIR/L=1337/O=ael-ghem/OU=IT Department/CN=Archi"
fi

#prepare nginx run dir
if [ ! -d "/run/nginx/" ]; then
	mkdir -p /run/nginx/
fi

#prepare openrc run dir
if [ ! -d "/run/openrc/" ]; then
  mkdir -p /run/openrc/
  touch /run/openrc/softlevel
fi
sh services.sh
