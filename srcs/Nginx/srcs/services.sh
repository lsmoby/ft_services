#!/bin/bash

rc-update add sshd
nginx -t
/usr/sbin/sshd -D

nginx -g "daemon off;" &

mkdir /liveness
touch /liveness/live

while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "sshd" ; [ $? -eq 1 ] && touch /liveness/sshd_
cat /liveness/processes | grep "nginx"; [ $? -eq 1 ] && touch /liveness/nginx_
if [ ! -f /liveness/nginx_ -o ! -f /liveness/sshd_ ]; then
    rm /liveness/live
fi
sleep 5
done