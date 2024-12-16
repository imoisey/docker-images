FROM ghcr.io/roadrunner-server/roadrunner:2024.3.0 AS roadrunner
FROM php:8.4.1-cli-alpine3.21

ARG USER_GID=65532
ARG USER_UID=65532

COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr

# Create user
RUN set -eux \
    && addgroup noroot -g ${USER_GID} \
    && adduser -D -s /bin/ash --uid ${USER_UID} --no-create-home noroot -G noroot \
    && true \
# Install dependencies
    && apk add --no-cache \
        icu-data-full \
        make \
        mimalloc2 \
        php84 \
        php84-ctype \
        php84-curl \
        php84-dom \
        php84-iconv \
        php84-intl \
        php84-mbstring \
        php84-opcache \
        php84-openssl \
        php84-pcntl \
        php84-pdo_pgsql \
        php84-pecl-apcu \
        php84-pecl-ast \
        php84-pecl-protobuf \
        php84-pecl-rdkafka --repository=https://dl-cdn.alpinelinux.org/alpine/v3.21/community \
        php84-pecl-redis \
        php84-pgsql \
        php84-phar \
        php84-simplexml \
        php84-soap \
        php84-sockets \
        php84-sodium \
        php84-tokenizer \
        php84-xml \
        php84-xmlwriter \
        php84-zip \
        tzdata \
    && rm -rf /usr/local/bin/php \
    && ln -s /usr/bin/php84 /usr/local/bin/php \
    && mkdir /var/www/app \
    && chown noroot:noroot /var/www/app -R \
    && true

# Install and configure your application
USER noroot
WORKDIR /var/www/app

