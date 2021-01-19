#!/bin/bash

(/opt/grafana/bin/grafana-server -homepath "/opt/grafana"  &)

while true;	do
sleep 5
ret1="$(ps | grep grafana | grep -vc grep)"
if [ $ret1 -eq 0 ]; then
    echo "pod is unhealthy"
    break ;
else
    echo "pod is healthy"
fi
done