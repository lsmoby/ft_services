#!/bin/bash
sh /telegraf.sh
(influxd &) && ( /telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &)

while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "telegraf" ; [ $? -eq 0 ] && touch /liveness/teleg_
cat /liveness/processes | grep "influxd"; [ $? -eq 0 ] && touch /liveness/influxd_
if [ ! -f /liveness/influxd_ -o ! -f /liveness/teleg_ ]; then
    rm /liveness/live
fi
rm /liveness/teleg_    /liveness/influxd_ /liveness/processes
sleep 5
done