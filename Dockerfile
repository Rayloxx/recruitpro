# Use the official PHP image with Apache
FROM php:8.2-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev && \
    docker-php-ext-install pdo pdo_mysql zip && \
    a2enmod rewrite

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy only the PHP app files (from jobs folder)
COPY jobs/ ./

# Install Composer globally
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose the port Apache runs on
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
