ARG USERNAME

FROM composer:2.8.4 AS composer
FROM ${USERNAME}/php:8.4.1-rr AS base

USER root
RUN apk update && apk add --no-cache \
    git \
    php84-xdebug \
    && true

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN echo "zend_extension=xdebug.so" >> /etc/php84/conf.d/50_xdebug.ini && \
    echo "xdebug.mode=debug" >> /etc/php84/conf.d/50_xdebug.ini && \
    echo "xdebug.start_with_request=yes" >> /etc/php84/conf.d/50_xdebug.ini && \
    echo "xdebug.client_host=host.docker.internal" >> /etc/php84/conf.d/50_xdebug.ini && \
    echo "xdebug.idekey=PHPSTORM" >> /etc/php84/conf.d/50_xdebug.ini && \
    echo "xdebug.client_port=9003" >> /etc/php84/conf.d/50_xdebug.ini

# Install and configure your application
USER noroot

#COPY --chown=noroot:noroot . /var/www/app

ENV COMPOSER_FUND=0
#RUN composer install --profile --no-interaction --no-cache --optimize-autoloader
