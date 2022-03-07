set -x \
    && apt update \
    && apt install --no-install-recommends -y zip git wget unzip gnupg2 locales apt-transport-https libpng-dev libwebp-dev libfreetype6-dev libjpeg62-turbo-dev libzip-dev zlib1g-dev libpq-dev libxml2-dev uuid-dev librabbitmq-dev unixodbc-dev libsybdb5 freetds-dev \
    && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list | tee /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure zip --with-zip \
    && docker-php-source extract \
    && curl -fsSL https://raw.githubusercontent.com/php/php-src/6a6c8a60965c6fc3f145870a49b13b719ebd4a72/ext/sockets/config.m4 -o /usr/src/php/ext/sockets/config.m4 \
    && docker-php-ext-install sockets \
    && docker-php-ext-install -j $(nproc) gd zip intl soap pcntl mysqli bcmath opcache pdo_pgsql pdo_dblib \
    && pecl install redis uuid mongodb amqp sqlsrv-5.10.0 pdo_sqlsrv-5.10.0 \
    && docker-php-ext-enable uuid redis mongodb amqp pdo_dblib sqlsrv pdo_sqlsrv \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i -e 's/expose_php = On/expose_php = Off/' "$PHP_INI_DIR/php.ini" \
    && echo "\nCPTimeout=300\n\n[ODBC]\nPooling=Yes" >> /etc/odbcinst.ini \
    && php -m \
    && php -v \
    php -i