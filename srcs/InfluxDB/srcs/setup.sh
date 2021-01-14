mkdir -p /usr/src /etc/telegraf
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.17.0_linux_amd64.tar.gz
tar -C /-xzf telegraf-1.17.0_linux_amd64.tar.gz

chmod +x /telegraf*/*
cp -a /telegraf*/* /