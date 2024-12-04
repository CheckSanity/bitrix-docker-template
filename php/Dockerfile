ARG PHP_VERSION=8.1
FROM php:${PHP_VERSION}-fpm

WORKDIR /var/www

ARG COMPOSER_VERSION=''

RUN apt-get update && apt-get install -y curl wget openssh-client git libzip-dev libgd-dev libfreetype6 libmcrypt-dev zip

RUN if [ -n "${COMPOSER_VERSION}" ]; then COMPOSER_VERSION="--version=${COMPOSER_VERSION}";fi;\
 curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer ${COMPOSER_VERSION}

RUN docker-php-ext-install mysqli -j$(nproc) calendar opcache && \
    docker-php-ext-configure opcache --enable-opcache && \
    docker-php-ext-install sockets

# Add WebP support
RUN apt-get install libwebp-dev
RUN docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp && docker-php-ext-install gd

RUN docker-php-ext-install zip

COPY php.ini                       $PHP_INI_DIR/php.ini
COPY php-fpm.d                     $PHP_INI_DIR/pool.d/
COPY conf.d                        $PHP_INI_DIR/conf.d/

ARG PHP_MBSTRING_FUNC_OVERLOAD=2
RUN sed -ri 's/@mbstring_func_overload@/'$PHP_MBSTRING_FUNC_OVERLOAD'/' $PHP_INI_DIR/php.ini

# Setup CRON
COPY cron.d /etc/cron.d
RUN apt --allow-releaseinfo-change update && apt install -y cron && chmod 644 /etc/cron.d/www && crontab /etc/crontab
RUN rm -rf /var/lib/apt/lists/*

ARG USER_ID
ARG GROUP
RUN usermod -u "$USER_ID" -a -G "$GROUP" www-data

EXPOSE 9000 22