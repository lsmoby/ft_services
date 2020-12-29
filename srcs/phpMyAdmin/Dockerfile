FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -eux && \
    apk add --no-cache --update bash \
    openrc \
    nginx \
    php7-fpm \
    wget \
    php-json    \
    php-mbstring \
    php-session
    #mbstring json session for phpmyadmin


RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz \
    && tar xvf phpMyAdmin-4.9.7-all-languages.tar.gz && mkdir /usr/share/phpmyadmin \
	&& mv phpMyAdmin-4.9.7-all-languages/* /usr/share/phpmyadmin && ln -s /usr/share/phpmyadmin /var/www/html
COPY srcs/setup.sh       /
COPY srcs/nginx.conf                    /etc/nginx/nginx.conf
RUN chmod -x setup.sh
EXPOSE 5000
ENTRYPOINT ["/setup.sh"]