# Use an official PHP image with Composer preinstalled
FROM php:8.2-apache

# Install required extensions for Laravel
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev && \
    docker-php-ext-install pdo pdo_mysql zip && \
    a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy composer files first to leverage Docker caching
COPY composer.json composer.lock ./

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Copy the rest of the application files
COPY . .

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose port 8080 (Render expects this)
EXPOSE 8080

# Start Apache
CMD ["apache2-foreground"]
