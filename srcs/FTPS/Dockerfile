FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade

#install services
RUN set -x && \
    apk add --update openrc && \
    apk add --update openssh && \
    apk add --update openssl && \
    apk add --update sudo && \
    rm  -rf /tmp/* /var/cache/apk/*

COPY srcs/ftps-entrypoint.sh /

RUN chmod +x ftps-entrypoint.sh
expose 21
ENTRYPOINT [ "/ftps-entrypoint.sh" ]
