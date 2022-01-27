FROM php:8.1.2-fpm-alpine3.15

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-enable pdo_mysql

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR "/app"
