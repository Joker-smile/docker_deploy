FROM bitnami/php-fpm:7.2
COPY u /app
WORKDIR /app

RUN install_packages curl vim git unzip wget autoconf apt-utils imagemagick gcc pkg-config
# Install required system packages and dependencies
#RUN install_packages build-essential ca-certificates curl autoconf ghostscript git imagemagick libbz2-1.0 libc6 libgcc1 libmysqlclient18 libncurses5 libreadline6 libsqlite3-0 libssl1.0.0 libstdc++6 libtinfo5 pkg-config unzip wget zlib1g

RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com && \
        pecl install swoole && \
        echo "extension=swoole.so" >> /opt/bitnami/php/lib/php.ini && \
        composer install --optimize-autoloader && \
        php artisan migrate && \
        php artisan config:cache && \
        php artisan route:cache

EXPOSE 1215

CMD ["php", "artisan", "laravels", "start"]
