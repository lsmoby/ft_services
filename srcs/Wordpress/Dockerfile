FROM alpine:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apk update && apk upgrade && apk add nginx



COPY srcs/services.sh /
RUN  apk add supervisor
COPY srcs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 80 443
CMD ["sh", "services.sh"]