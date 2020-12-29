FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -eux && \
    apk add --no-cache --update bash \
    nginx \
    php7-fpm \
    wget \
    php-json    \
    php-mbstring \
    php-session
    #mbstring json session for phpmyadmin
RUN set -eux; \
	addgroup -g 82 -S www-data; \
	adduser -u 82 -D -S -G www-data www-data
RUN set -eux; \
	mkdir -p /usr/local/etc/php/conf.d; \
	[ ! -d /var/www/html ]; \
	mkdir -p /var/www/html; \
	chown www-data:www-data /var/www/html; \
	chmod 777 /var/www/html

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz \
    && tar xvf phpMyAdmin-4.9.7-all-languages.tar.gz && mkdir /usr/share/phpmyadmin \
	&& mv phpMyAdmin-4.9.7-all-languages/* /usr/share/phpmyadmin && ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
COPY srcs/setup.sh       /
COPY srcs/nginx.conf                    /etc/nginx/nginx.conf
RUN chmod +x setup.sh
EXPOSE 5050
ENTRYPOINT ["/setup.sh"]