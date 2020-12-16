openrc
openrc reboot
rc-status
rc-update add sshd
rc-service nginx start
rc-service sshd restart
sshd -D
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf