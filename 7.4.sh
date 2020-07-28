set -x \
    && apt-get update \
    && apt-get install -y libpq-dev libzip-dev librabbitmq-dev libssh-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libxml2-dev libsybdb5 freetds-dev locales gnupg2 apt-transport-https \
    && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list | tee /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-configure zip \
    && docker-php-ext-install -j$(nproc) zip soap opcache pdo_dblib gd pdo_mysql pdo_pgsql bcmath sockets \
    && pecl install mongodb amqp redis sqlsrv-5.8.1 pdo_sqlsrv-5.8.1 \
    && docker-php-ext-enable mongodb amqp redis sqlsrv pdo_sqlsrv \
    && rm -rf /var/lib/apt/lists/* \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i -e 's/expose_php = On/expose_php = Off/' "$PHP_INI_DIR/php.ini"