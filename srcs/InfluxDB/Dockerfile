FROM alpine:3.12

#update and upgrade
RUN apk update && apk upgrade
#install services
RUN set -eux && \
    apk add  --no-cache --update influxdb \
    libc6-compat    \
    bash

COPY srcs/telegraf.sh /
COPY srcs/telegraf.conf /etc/telegraf/
COPY srcs/setup.sh /
RUN  chmod +x setup.sh
EXPOSE 8086
ENTRYPOINT  [ "/setup.sh" ]