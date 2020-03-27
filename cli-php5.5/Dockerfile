
# PHP
FROM php:5.5-apache

# install PHP extensions (https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions)
ENV RUBYOPT -EUTF-8
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ghostscript \
    libfreetype6-dev \
    libjpeg-dev \
    libmagickwand-dev \
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
    bcmath \
    exif \
    gd \
    mbstring \
    mysqli \
    opcache \
    pdo_mysql \
    zip \
  && a2enmod rewrite \
  && pecl install imagick-3.4.4 \
  && docker-php-ext-enable imagick \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/*


# Xdebug
RUN pecl install xdebug-2.5.5 \
  && docker-php-ext-enable xdebug

# MailCatcher
RUN gem install mailcatcher

# WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && wp --info


# set recommended PHP.ini settings (https://secure.php.net/manual/en/opcache.installation.php)
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
  } > /usr/local/etc/php/conf.d/opcache-recommended.ini


WORKDIR /var/www
