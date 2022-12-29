FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
  git \
  libpng-dev \
  zip \
  unzip \
  curl

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-configure gd
RUN docker-php-ext-install opcache
RUN docker-php-ext-enable opcache
RUN pecl install redis
RUN docker-php-ext-enable redis

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www