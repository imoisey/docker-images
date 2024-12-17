ARG USERNAME

FROM composer:2.8.4 AS composer
FROM ${USERNAME}/php:8.4.1-rr AS base

USER root
RUN apk update && apk add git

COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install and configure your application
USER noroot

#COPY --chown=noroot:noroot . /var/www/app

ENV COMPOSER_FUND=0
#RUN composer install --profile --no-interaction --no-cache --optimize-autoloader
