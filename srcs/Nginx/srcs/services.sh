openrc
openrc reboot
rc-status
rc-update add sshd
rc-service sshd start
sshd -D
rc-service nginx start
nginx -g "daemon off;"