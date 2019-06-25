FROM php:5.6-fpm

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
                mysql-client \
                zip \
                libzip-dev \
                zlib1g-dev \
                libicu-dev \
                g++ \
	&& docker-php-ext-install -j$(nproc) iconv \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install -j$(nproc) mysqli \
	&& docker-php-ext-install -j$(nproc) pdo_mysql \
        && docker-php-ext-install -j$(nproc) zip \
        && docker-php-ext-install -j$(nproc) intl

#RUN yes | pecl install xdebug

# Add custom ini                       
COPY php/5.6/custom.ini $PHP_INI_DIR/conf.d/custom.ini
# Add xdebug configuration
COPY php/5.6/xdebug.ini $PHP_INI_DIR/conf.d/xdebug.ini

