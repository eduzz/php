ARG PHP_VERSION=8.5

FROM php:${PHP_VERSION}-fpm-bookworm

ENV PHP_VERSION=${PHP_VERSION}

COPY packages.sh /tmp

RUN set -x \
    && chmod +x /tmp/packages.sh \
    && /tmp/packages.sh \
    && echo "\nCPTimeout=300\n\n[ODBC]\nPooling=Yes" >> /etc/odbcinst.ini \
    && rm /tmp/*.sh

COPY freetds.conf /etc/freetds/freetds.conf
COPY openssl.cnf /etc/ssl/openssl.cnf

USER www-data
EXPOSE 9000
ENV HOSTNAME=localhost