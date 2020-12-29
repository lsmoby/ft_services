rc-update add sshd
nginx -t
nginx
/usr/sbin/sshd -D
nginx -g "daemon off;"