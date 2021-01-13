FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade
#install services
RUN set -eux && \
    apk add --no-cache --update \
    openrc \
    vsftpd \
    openssl

COPY srcs/setup.sh /
RUN chmod +x setup.sh
EXPOSE 21 30000-30009
#ENTRYPOINT ["/setup.sh"]
CMD sh setup.sh