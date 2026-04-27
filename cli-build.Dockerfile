ARG PHP_VERSION=8.5

FROM php:${PHP_VERSION}-cli-bookworm

ENV PHP_VERSION=${PHP_VERSION}
ENV XDEBUG_MODE=coverage

COPY packages.sh composer.sh /tmp/

RUN set -x \
    && chmod +x /tmp/*.sh \
    && /tmp/packages.sh \
    && /tmp/composer.sh \
    && rm /tmp/*.sh

COPY freetds.conf /etc/freetds/freetds.conf
COPY openssl.cnf /etc/ssl/openssl.cnf

USER www-data
ENV HOSTNAME=localhost