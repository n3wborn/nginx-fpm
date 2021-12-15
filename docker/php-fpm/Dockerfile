FROM phpdockerio/php:8.1-fpm
WORKDIR "/app"

RUN apt-get update; \
    apt-get -y --no-install-recommends install \
        php8.1-bcmath \
        php8.1-intl \
        php8.1-mysql \
        php8.1-pgsql \
        php8.1-sqlite3 \
        php8.1-uuid; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
