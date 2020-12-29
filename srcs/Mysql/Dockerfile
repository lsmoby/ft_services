FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -eux && \
    apk add --no-cache --update \
    openrc  \
    mysql   \
    mysql-client

COPY srcs/setup.sh      /
COPY srcs/mysqlconfig.cnf /etc/mysql/mysqlconfig.cnf

RUN chmod +x setup.sh
EXPOSE 3306
ENTRYPOINT ["/setup.sh"]