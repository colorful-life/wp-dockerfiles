
FROM wordpress:5.3-php7.4-apache

# Xdebug
RUN pecl install xdebug-2.9.8 \
  && docker-php-ext-enable xdebug

# MailCatcher
ENV RUBYOPT -EUTF-8
RUN apt-get update -qq \
  && apt-get install -y \
    ruby \
    ruby-dev \
    rubygems \
    libsqlite3-dev \
    libpq-dev \
  && docker-php-ext-install pdo_mysql \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN gem install mailcatcher

# WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp \
  && wp --info

WORKDIR /var/www
