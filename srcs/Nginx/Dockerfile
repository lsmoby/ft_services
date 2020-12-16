FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -x && \
    apk add --update nginx && \
    apk add --update openrc && \
    apk add --update openssl && \
    apk add --update supervisor && \
    apk add --update openssh && \
    rm  -rf /tmp/* /var/cache/apk/*
COPY srcs/services.sh /
COPY srcs/docker-nginx-entrypoint.sh /
    #cleaning old ssh keys
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY srcs/index.html /var/www/index.html
RUN rm -f /etc/nginx/conf.d/default.conf
RUN chmod +x docker-nginx-entrypoint.sh
COPY srcs/default.conf /etc/nginx/conf.d/default.conf
COPY srcs/sshd_config /etc/ssh/
EXPOSE 80 443 22
ENTRYPOINT [ "/docker-nginx-entrypoint.sh" ]
# CMD [ "sh", "services.sh" ]