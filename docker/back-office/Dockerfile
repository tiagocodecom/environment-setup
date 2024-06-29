ARG PHP_VERSION=8.3-fpm
ARG BACK_OFFICE_VERSION=latest
ARG CONTAINER_REGISTRY_URL=ghcr.io

FROM ${CONTAINER_REGISTRY_URL}/tiagocodecom/back-office:${BACK_OFFICE_VERSION} AS back-office

LABEL author="Tiagocode <santiagomm1997@gmail.com>"
LABEL mantainer="Tiagocode <santiagomm1997@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/tiagocodecom/back-office"

FROM php:${PHP_VERSION}

RUN set -xe; \
    \
    apk add --update --no-cache shadow; \
    \
    apk add --update --no-cache -t .php-run-deps \ 
        make \ 
        bash \  
        curl \ 
        findutils \ 
        git \
        gmp \
        gzip \ 
        imagemagick \
        imagemagick-heic \
        imagemagick-jpeg \
        imagemagick-pdf \
        imagemagick-svg \
        imagemagick-tiff \
        imagemagick-webp \
        jpegoptim \
        less \
        libavif \
        libbz2 \ 
        libgd \
        libgomp \
        libjpeg-turbo \
        libjpeg-turbo-utils \ 
        libmemcached-libs \
        libmcrypt \
        libpng \ 
        libsmbclient \
        libuuid \
        libwebp \
        libxml2 \ 
        libzip \ 
        nano \
        openssh \
        openssh-client \ 
        postgresql-client \ 
        rsync \ 
        su-exec \
        sudo \
        tar \  
        unzip \
        wget \
        yaml; \
    \
    apk add --update --no-cache -t .wodby-php-build-deps \
        autoconf \
        automake \
        binutils \
        cmake \   
        gd-dev \
        gmp-dev \  
        imagemagick-dev \
        jpeg-dev \  
        libgcrypt-dev \
        libjpeg-turbo-dev \
        libmemcached-dev \
        libmcrypt-dev \
        libpng-dev \ 
        libtool \
        libwebp-dev \ 
        libzip-dev \
        linux-headers \ 
        openssl-dev \ 
        postgresql-dev \     
        yaml-dev \
        zlib-dev; \
    \
    wget -qO- https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; 

RUN set -xe; \
    \
    docker-php-source extract; \
    cp /usr/src/php/php.ini-production "${PHP_INI_DIR}/php.ini"; \
    \
    NPROC=$(getconf _NPROCESSORS_ONLN); \
    \
    docker-php-ext-install "-j${NPROC}" \
        bcmath \
        bz2 \  
        gmp \
        intl \ 
        mysqli \
        opcache \  
        pdo_pgsql \
        pgsql \
        zip; \
    \
    MAKEFLAGS="-j ${NPROC}" pecl install \ 
        memcached-3.2.0 \ 
        uploadprogress-2.0.2 \
        xdebug-3.4.1 \ 
        yaml-2.2.4; \
    \
    docker-php-ext-enable \ 
        memcached \
        uploadprogress \
        xdebug \ 
        yaml; \
    \
    docker-php-ext-configure gd \
                --with-external-gd \
                --with-webp \
                --with-freetype \
                --with-avif \
                --with-jpeg; \
    docker-php-ext-install "-j${NPROC}" gd;
    
RUN set -xe; \
    apk del --purge .php-build-deps; \
    pecl clear-cache; 


# Ensure correct permissions for bind volume
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto de PHP-FPM
EXPOSE 9000

CMD ["php-fpm"]