set -x \
    && apt-get update \
    && apt-get install -y gnupg libpq-dev uuid-dev libsodium-dev libzip-dev librabbitmq-dev libssh-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libxml2-dev libsybdb5 freetds-dev locales gnupg2 apt-transport-https \
    && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
    && curl https://packages.microsoft.com/config/debian/12/prod.list | tee /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev libltdl-dev libodbc1 \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-configure zip \
    && docker-php-ext-install -j$(nproc) pcntl intl zip soap opcache pdo_dblib gd pdo_mysql pdo_pgsql bcmath sockets \
    && pecl channel-update pecl.php.net \
    && pecl install libsodium mongodb amqp redis uuid sqlsrv-5.12.0 pdo_sqlsrv-5.12.0 \
    && docker-php-ext-enable mongodb amqp redis sqlsrv pdo_sqlsrv \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && sed -i -e 's/expose_php = On/expose_php = Off/' "$PHP_INI_DIR/php.ini" \
    && (groupadd www-data -g 1000 || echo "group www-data already exists.") \
    && (useradd www-data -u 1000 -g 1000 || echo "user www-data already exists.") \
    && apt-get remove -y gnupg libltdl-dev unixodbc-dev libpq-dev uuid-dev libsodium-dev libzip-dev librabbitmq-dev libssh-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libxml2-dev freetds-dev \
    && rm -rf /var/lib/apt/lists/*