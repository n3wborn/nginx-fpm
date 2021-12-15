FROM php:8.1.0-fpm-alpine

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR "/app"
