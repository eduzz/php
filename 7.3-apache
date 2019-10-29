FROM php:7.3-apache

COPY 7.3.sh /tmp

RUN chmod +x /tmp/7.3.sh && /tmp/7.3.sh

COPY freetds.conf /etc/freetds/freetds.conf
COPY openssl.cnf /etc/ssl/openssl.cnf