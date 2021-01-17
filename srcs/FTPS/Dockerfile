FROM alpine:3.12

#update and upgrade
RUN apk update && apk upgrade
#install services
RUN set -eux && \
    apk add --no-cache --update \
    openssl libc6-compat   bash && \
    apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY srcs/setup.sh /
COPY srcs/telegraf.conf /etc/telegraf/
COPY srcs/telegraf.sh /
RUN chmod +x setup.sh
EXPOSE 21 30000-30009
ENTRYPOINT ["/setup.sh"]