FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade
#install services
RUN set -eux && \
    apk add influxdb

COPY srcs/setup.sh /
RUN sh setup.sh
ENTRYPOINT  [ "influxd" ]