mkdir -p /etc/ssl/private /etc/ssl/certs/
openssl req -x509 -nodes -days 720 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/certs/vsftpd.pem -subj "/C=MA/ST=BENGUERIR/L=1337/O=ael-ghem/OU=IT Department/CN=Archi"
echo -e "anonymous_enable=YES
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
ftpd_banner=Welcome to FTPS server from the ft_services 42 project.
listen=YES
seccomp_sandbox=NO
rsa_cert_file=/etc/ssl/certs/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
ssl_tlsv1=NO
ssl_sslv2=NO
ssl_sslv3=NO
ssl_enable=YES
pasv_address=$PASVADDR
pasv_enable=YES
pasv_max_port=30009
pasv_min_port=30000
force_local_data_ssl=YES
force_local_logins_ssl=YES
require_ssl_reuse=NO
ssl_ciphers=HIGH:MEDIUM"  > /etc/vsftpd/vsftpd.conf

if [[ ! -z "$FTP_USER" ]] && [[ ! -z "$FTP_PASS" ]]
then
    addgroup -g 433 -S $FTP_USER
    adduser -u 431 -D -G $FTP_USER -h /home/$FTP_USER -s /bin/false  $FTP_USER
    echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd
    chown $FTP_USER:$FTP_USER /home/$FTP_USER/ -R
    echo FTPS_USER = $FTP_USER
fi

chmod 600 /etc/ssl/certs/vsftpd.pem
chmod 600 /etc/ssl/private/vsftpd.pem


/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf