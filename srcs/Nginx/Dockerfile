FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -x && \
    apk add --update bash && \
    apk add --update nginx && \
    apk add --update openrc && \
    apk add --update openssl && \
    apk add --update openssh && \
    rm  -rf /tmp/* /var/cache/apk/*

RUN rm -f /etc/nginx/nginx.conf
COPY srcs/services.sh                   /
COPY srcs/setup.sh           /
COPY srcs/sshd_config                   /etc/ssh/
COPY srcs/index.html                    /var/www/html/index.html
COPY srcs/nginx.conf                    /etc/nginx/nginx.conf

RUN chmod +x setup.sh
EXPOSE 80 443 22
ENTRYPOINT [ "/setup.sh" ]
