FROM alpine:latest

#update and upgrade
RUN apk update && apk upgrade
#install services
RUN set -eux && \
    apk add --update wget ca-certificates && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk \
    apk add --allow-untrusted glibc-*.apk && \
    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true && \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
    mkdir /opt && cd /opt && \
    wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/dist/grafana-latest.linux-x64.tar.gz && \
    tar -xzf grafana-*linux-x64.tar.gz  \
    apk del --purge wget glibc-i18n && \
    rm -rf /tmp/* /var/cache/apk/* /opt/*tar.gz && \
    mv grafana-* grafana

COPY srcs/setup.sh /
RUN chmod +x setup.sh
EXPOSE 3000
ENTRYPOINT ["/setup.sh"]