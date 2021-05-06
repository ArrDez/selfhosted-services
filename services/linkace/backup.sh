#!/usr/bin/env bash
set -e

BASE_DIR=$(dirname $(realpath $0))
DATE=$( date +"%F" )
CONTAINER_NAME="linkacedb"
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

COMMAND="mysqldump -h ${CONTAINER_IP_ADDR} -u root ${DB_DATABASE} > /backup/linkace_db_${DATE}.sql"

docker run \
  --network traefik_net \
  --env "MYSQL_PWD=${DB_PASSWORD}" \
  -v "$TARGET_DIR:/backup" \
  mariadb:10.5 bash -c "$COMMAND"