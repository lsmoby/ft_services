FROM alpine:3.12

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -eux && \
    apk add --no-cache --update \
    openrc \
    bash   \
    mysql  \
    mysql-client && \
    mkdir -p /etc/mysql/ /etc/my.cnf.d/

COPY srcs/setup.sh      /
COPY srcs/my.cnf /etc/mysql/my.cnf
COPY srcs/mariadb-server.cnf /etc/my.cnf.d/
RUN chmod +x setup.sh
EXPOSE 3306
ENTRYPOINT ["/setup.sh"]