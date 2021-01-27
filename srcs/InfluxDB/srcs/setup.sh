#!/bin/bash
sh /telegraf.sh
(influxd &) && ( /telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &)

while true;	do
sleep 5
ret1="$(ps | grep telegraf | grep -vc grep)"
ret2="$(ps | grep influxd | grep -vc grep)"
if [ $ret1 -eq 0 -o $ret2 -eq 0 ]; then
    echo "pod is unhealthy"
    break ;
else
    echo "pod is healthy"
fi
done