#!/bin/bash

rc-update add sshd
nginx -t
/usr/sbin/sshd -D

sh /telegraf.sh
(nginx -g "daemon off;" &) && ( /telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &)

mkdir /liveness
touch /liveness/live

while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "/telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf" ; [ $? -eq 1 ] && touch /liveness/teleg_
cat /liveness/processes | grep "nginx"; [ $? -eq 1 ] && touch /liveness/nginx_
if [ ! -f /liveness/nginx_ -o ! -f /liveness/teleg_ ]; then
    rm /liveness/live
fi
sleep 5
done