#!/usr/bin/env bash
set -e 

CONTAINER_ID=$(docker container ls -a -f name=fireflyiii_fireflyiii_1 --format="{{.ID}}")

0 3 * * * docker exec --user www-data $CONTAINER_ID /usr/local/bin/php /var/www/html/artisan firefly-iii:cron
