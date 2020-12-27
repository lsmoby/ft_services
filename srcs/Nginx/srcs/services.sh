rc-update -q add sshd
/usr/sbin/sshd -D
nginx -t
nginx
nginx -g "daemon off;"