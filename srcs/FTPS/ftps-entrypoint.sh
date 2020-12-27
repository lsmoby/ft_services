if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
	# generate fresh rsa key
	ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
	# create ssh user and password
	useradd -rm -d /home -s sh -g root -G sudo -u 1000 admin
	RUN echo "admin:1234" | chpasswd
fi

#prepare sshd run dir
if [ ! -d "/var/run/sshd" ]; then
  mkdir -p /var/run/sshd
fi

if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
	# generate fresh dsa key
	ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

#prepare openrc run dir
if [ ! -d "/run/openrc/" ]; then
  mkdir -p /run/openrc/
  touch /run/openrc/softlevel
fi
