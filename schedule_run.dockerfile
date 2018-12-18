FROM bitnami/php-fpm:7.2
COPY u /app
WORKDIR /app

RUN rm -rf /etc/apt/sources.list && wget -O /etc/apt/sources.list http://mirrors.163.com/.help/sources.list.jessie && apt-get update

RUN install_packages curl vim git unzip wget autoconf apt-utils imagemagick gcc pkg-config cron

RUN    composer config -g repo.packagist composer https://packagist.laravel-china.org && \
       composer install && \
#       pecl install memcached && \
#       echo "extension=memcached.so" >> /opt/bitnami/php/lib/php.ini && \
       php artisan migrate && \
       php artisan config:cache && \
       php artisan route:cache

RUN echo "* * * * * php /app/artisan schedule:run >> /dev/null 2>&1" >> /etc/crontab

CMD ["cron"]
