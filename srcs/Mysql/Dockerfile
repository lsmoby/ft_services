FROM alpine:3.12

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -eux && \
    apk add --no-cache --update \
    openrc  libc6-compat    bash    \
    mysql   \
    mysql-client && \
    mkdir -p /etc/mysql/ /etc/my.cnf.d/

COPY srcs/setup.sh      /
COPY srcs/my.cnf /etc/mysql/my.cnf
COPY srcs/mariadb-server.cnf /etc/my.cnf.d/
COPY srcs/telegraf.conf /etc/telegraf/
COPY srcs/telegraf.sh /
RUN chmod +x setup.sh
EXPOSE 3306
ENTRYPOINT ["/setup.sh"]