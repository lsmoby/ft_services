FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -x && \
    apk add --update nginx && \
    apk add --update openrc && \
    apk add --update openssl && \
    apk add --update openssh && \
    apk add --update bash && \
    apk add --update sudo && \
    rm  -rf /tmp/* /var/cache/apk/*

RUN rm -f /etc/nginx/nginx.conf
COPY srcs/services.sh /
COPY srcs/nginx-entrypoint.sh /
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY srcs/index.html /var/www/index.html
COPY srcs/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x nginx-entrypoint.sh
EXPOSE 80 443 22
ENTRYPOINT [ "/nginx-entrypoint.sh" ]
