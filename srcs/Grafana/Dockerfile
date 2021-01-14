FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade
#install services
RUN set -eux && cd /tmp && \
    apk add --update wget ca-certificates && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
    apk add --allow-untrusted glibc-*.apk && \
    wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/dist/grafana-latest.linux-x64.tar.gz && \
    tar -xzf grafana-*linux-x64.tar.gz -C /opt && mv /opt/grafana-* /opt/grafana && \
    apk del --purge wget && \
    rm -rf /tmp/* /var/cache/apk/*

COPY srcs/setup.sh /
RUN chmod +x setup.sh
EXPOSE 3000
ENTRYPOINT  [ "/opt/grafana/bin/grafana-server",  "-homepath", "/opt/grafana" ]