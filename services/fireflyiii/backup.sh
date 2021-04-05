#!/usr/bin/env bash
set -e

BASE_DIR=$(dirname $(realpath $0))
DATE=$( date +"%F" )
CONTAINER_NAME="fireflyiiidb"
TARGET_DIR="$BASE_DIR/backup"

# GET VARS FROM .env
DB_USERNAME=$(grep DB_USERNAME ${BASE_DIR}/.env | cut -d '=' -f 2-)
DB_DATABASE=$(grep DB_DATABASE ${BASE_DIR}/.env | cut -d '=' -f 2-)
DB_PASSWORD=$(grep DB_PASSWORD ${BASE_DIR}/.env | cut -d '=' -f 2-)

getContainerIP () {
  local CONTAINER_ID=$(docker ps | grep "$1" | awk '{print $1}' | head -n 1)
  docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID
}

CONTAINER_IP_ADDR=$(getContainerIP $CONTAINER_NAME)

COMMAND="pg_dump -h ${CONTAINER_IP_ADDR} --username=${DB_USERNAME} ${DB_DATABASE} > /fireflyiii_db_backup/firefly_db_${DATE}.sql"

docker run \
  --network traefik_net \
  --env "PGPASSWORD=${DB_PASSWORD}" \
  -v "$TARGET_DIR:/fireflyiii_db_backup" \
  postgres:13-alpine bash -c "$COMMAND"