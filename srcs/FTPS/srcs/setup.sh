#!/bin/bash
sh /telegraf.sh

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=MA/ST=benguerir/L=maroc/O=ael-ghem/OU=1337/CN=localhost"
chmod 600 /etc/ssl/private/pure-ftpd.pem
echo -e "TLS                         2
TLSCipherSuite               HIGH:MEDIUM:+TLSv1:!SSLv2:!SSLv3
CertFileAndKey    \"/etc/ssl/private/pure-ftpd.pem\" ">> /etc/pure-ftpd.conf

if [[ ! -z "$FTP_USER" ]] && [[ ! -z "$FTP_PASS" ]]
then
    adduser -D $FTP_USER
    echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd
fi

(pure-ftpd -j -Y 2 -p 30000:30009 -P $PASV_ADDRESS &) && ( /telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf &)

mkdir /liveness
touch /liveness/live

while true;	do
ps > /liveness/processes && cat /liveness/processes | grep "/telegraf-1.17.0/usr/bin/telegraf --config /etc/telegraf/telegraf.conf" ; [ $? -eq 1 ] && touch /liveness/teleg_
cat /liveness/processes | grep "pure-ftpd"; [ $? -eq 1 ] && touch /liveness/pure_
if [ ! -f /liveness/pure_ -o ! -f /liveness/teleg_ ]; then
    rm /liveness/live
fi
sleep 5
done