set -x \
    && apt-get update \
    && apt-get install -y zip unzip git \
    && pecl install pcov xdebug-3.4.0 \
    && docker-php-ext-enable pcov xdebug \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin \
    && php -r "unlink('composer-setup.php');" \
    && rm -rf /var/lib/apt/lists/*