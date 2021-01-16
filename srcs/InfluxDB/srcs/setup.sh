#!/bin/bash
sh /telegraf.sh
(influxd &) && ( /telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &)

mkdir /liveness
touch /liveness/live

while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "/telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf" ; [ $? -eq 1 ] && touch /liveness/teleg_
cat /liveness/processes | grep "influx"; [ $? -eq 1 ] && touch /liveness/influx_
if [ ! -f /liveness/influx_ -o ! -f /liveness/teleg_ ]; then
    rm /liveness/live
fi
sleep 5
done