FROM foru/backend:1.0
COPY u /app
WORKDIR /app

RUN install_packages cron
RUN    composer config -g repo.packagist composer https://packagist.laravel-china.org && \
       composer install && \
       chmod -R 777 storage && \
       php artisan migrate && \
       php artisan config:cache && \
       php artisan route:cache && \
    apt-get update && echo "* * * * * /opt/bitnami/php/bin/php /app/artisan schedule:run >> /dev/null 2>&1" >> /etc/crontab

#EXPOSE 9000

#CMD ["php-fpm", "-F", "--pid" , "/opt/bitnami/php/tmp/php-fpm.pid", "-c", "/opt/bitnami/php/lib/php.ini", "-y", "/opt/bitnami/php/etc/php-fpm.conf"]
