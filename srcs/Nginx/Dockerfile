FROM alpine:3.12

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -x && \
    apk add  --no-cache --update bash  nginx  openrc openssl  openssh

RUN rm -f /etc/nginx/nginx.conf
COPY srcs/setup.sh           /
COPY srcs/sshd_config                   /etc/ssh/
COPY srcs/index.html                    /var/www/html/index.html
COPY srcs/nginx.conf                    /etc/nginx/nginx.conf

RUN chmod +x setup.sh
EXPOSE 80 443 22
ENTRYPOINT [ "/setup.sh" ]
