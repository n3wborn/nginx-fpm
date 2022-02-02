FROM php:8.1.2-fpm-alpine3.15

RUN apk add --no-cache \
    acl \
    fcgi \
    file \
    gettext \
    git \
    gnu-libiconv \
  ;

# install gnu-libiconv and set LD_PRELOAD env to make iconv work fully on Alpine image.
# see https://github.com/docker-library/php/issues/240#issuecomment-763112749
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

ARG APCU_VERSION=5.1.21

RUN set -eux; \
  apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    icu-dev \
    libzip-dev \
    zlib-dev \
    libpq-dev \
  ; \
  \
  docker-php-ext-configure zip; \
  docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    intl \
    zip \
  ; \
  \
  pecl install \
    apcu-${APCU_VERSION} \
  ; \
  \
  pecl clear-cache; \
  docker-php-ext-enable \
    pdo_mysql \
    apcu \
    opcache \
  ; \
  \
  runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
    | tr ',' '\n' \
    | sort -u \
    | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
  )"; \
  \
  apk add --no-cache --virtual .phpexts-rundeps $runDeps; \
  \
  apk del .build-deps

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /app
