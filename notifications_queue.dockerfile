FROM foru/backend:1.0
COPY u /app
WORKDIR /app

RUN    composer config -g repo.packagist composer https://packagist.laravel-china.org && \
       composer install && \
       php artisan config:cache && \
       php artisan route:cache

CMD ["php","artisan","queue:work","redis","--queue=notifications","--timeout=60","--sleep=3","--tries=3"]

