#!/bin/sh

if [ ! -f /etc/ssl/certs/key.key -o ! -f /etc/ssl/certs/cer.crt ]; then
	# generate fresh ssl certificate and private key
	mkdir -p /etc/ssl/certs/
	openssl req -newkey rsa:2048 -nodes -keyout /etc/ssl/certs/key.key -x509 -days 365 -out /etc/ssl/certs/cer.crt -subj "/C=MA/ST=BENGUERIR/L=1337/O=ael-ghem/OU=IT Department/CN=Archi"
fi

if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
	# generate fresh rsa key
	ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
	# create ssh user and password
	useradd -rm -d /home -s sh -g root -G sudo -u 1000 admin
	RUN echo "admin:1234" | chpasswd
fi

if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
	# generate fresh dsa key
	ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

#prepare nginx run dir
if [ ! -d "/run/nginx/" ]; then
	mkdir -p /run/nginx/
fi

#prepare sshd run dir
if [ ! -d "/var/run/sshd" ]; then
  mkdir -p /var/run/sshd
fi

#prepare openrc run dir
if [ ! -d "/run/openrc/" ]; then
  mkdir -p /run/openrc/
  touch /run/openrc/softlevel
fi
sh services.sh