#!/usr/bin/env bash
set -e

BASE_DIR=$(dirname $(realpath $0))
DATE=$( date +"%F" )
TARGET_DIR="$BASE_DIR/backup"

mkdir -p $TARGET_DIR
rsync -avzP "$BASE_DIR/containerfs/data/" "$TARGET_DIR/shaarli-data-$DATE"