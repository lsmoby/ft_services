FROM alpine:3.12

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -eux && \
    apk add --no-cache --update bash \
    openrc \
    sed \
    nginx \
    php7-fpm \
    wget \
    php-json    \
    php-mbstring \
    php-session   \
    php-mysqli  \
    bash

RUN wget https://wordpress.org/latest.tar.gz \
    && tar xvf latest.tar.gz && mkdir -p /var/www/html \
	&& mv wordpress/* /var/www/html/
COPY srcs/setup.sh       /
COPY srcs/nginx.conf     /etc/nginx/nginx.conf
RUN chmod +x setup.sh
EXPOSE 5050
ENTRYPOINT ["/setup.sh"]