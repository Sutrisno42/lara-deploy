FROM dunglas/frankenphp

WORKDIR /app

COPY . /app

RUN apt update && apt install zip libzip-dev -y && \
    docker-php-ext-install zip && \
    docker-php-ext-enable zip

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader

EXPOSE 80

CMD ["php", "artisan", "octane:start", "--server=frankenphp", "--host=0.0.0.0", "--port=80"]
