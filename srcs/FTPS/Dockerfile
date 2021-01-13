FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade
#install services
RUN set -eux && \
    apk add --no-cache --update \
    openssl && \
    apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY srcs/setup.sh /
RUN chmod +x setup.sh
EXPOSE 21 30000-30009
ENTRYPOINT ["/setup.sh"]