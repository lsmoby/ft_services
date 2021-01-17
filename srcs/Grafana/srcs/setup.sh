#!/bin/bash
sh /telegraf.sh
(/opt/grafana/bin/grafana-server -homepath "/opt/grafana" &) && ( /telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &)

mkdir /liveness
touch /liveness/live

while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "/telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf" ; [ $? -eq 1 ] && touch /liveness/teleg_
cat /liveness/processes | grep "grafana"; [ $? -eq 1 ] && touch /liveness/grafana_
if [ ! -f /liveness/grafana_ -o ! -f /liveness/teleg_ ]; then
    rm /liveness/live
fi
sleep 5
done