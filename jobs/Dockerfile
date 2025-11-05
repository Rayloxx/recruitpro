# Use PHP with Apache
FROM php:8.2-apache

# Install required system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev libjpeg-dev libfreetype6-dev libwebp-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install pdo pdo_mysql zip gd bcmath exif \
    && a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Copy Composer from official image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --ignore-platform-req=ext-gd --ignore-platform-req=ext-exif --ignore-platform-req=ext-bcmath

# Expose Apache port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
