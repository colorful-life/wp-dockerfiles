
# PHP
FROM php:5.4-apache

# install PHP extensions (https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions)
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ghostscript \
    libfreetype6-dev \
    libmagickwand-dev \
    libjpeg-dev \
    libpng-dev \
    libsqlite3-dev \
    libzip-dev \
    mysql-client \
    openssl \
    ruby \
    ruby-dev \
    rubygems \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install \
    exif \
    gd \
    mbstring \
    mysqli \
    pdo_mysql \
    zip \
  && a2enmod rewrite \
  && pecl install imagick-3.4.4 \
  && docker-php-ext-enable imagick \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*


# Xdebug
RUN pecl install xdebug-2.4.1 \
  && docker-php-ext-enable xdebug

# MailCatcher
RUN gem install mailcatcher

# WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && wp --info

WORKDIR /var/www
