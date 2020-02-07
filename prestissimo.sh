set -x \
    && apt-get update \
    && apt-get install -y zip unzip git \
    && pecl install xdebug-2.8.1 \
    && docker-php-ext-enable xdebug \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin \
    && php -r "unlink('composer-setup.php');" \
    && composer.phar global require hirak/prestissimo \
    && rm -rf /var/lib/apt/lists/*