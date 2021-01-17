FROM alpine:3.12

#update and upgrade
RUN apk update && apk upgrade
#install services
RUN set -eux && cd /tmp && \
    apk add  --no-cache --update wget ca-certificates libc6-compat bash && \
    wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/dist/grafana-latest.linux-x64.tar.gz && \
    tar -xzf grafana-*linux-x64.tar.gz -C /opt && mv /opt/grafana-* /opt/grafana && \
    apk del --purge wget && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 3000
ENTRYPOINT  [ "/opt/grafana/bin/grafana-server", "-homepath", "/opt/grafana" ]