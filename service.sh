#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

checkDirExsistance() {
  if [ ! -d $1 ]; then
    echo "Service does not exist"
    exit 1
  fi
}

backup() {
  local SCRIPT_PATH="$1/backup.sh"
   if [ ! -f $SCRIPT_PATH ]; then
    echo "Backup script does not exist"
    exit 1
  fi
  $SCRIPT_PATH
}

if [[ -z "$1" ]]; then
 echo "Service must be specified"
 exit 1
fi

SERVICE_PATH="${SCRIPT_DIR}/services/${1}"

checkDirExsistance $SERVICE_PATH
 
case "$2" in
    backup)
      shift
      backup "$SERVICE_PATH"
    ;;
    *)
      shift
      docker-compose --project-directory $SERVICE_PATH -f "${SERVICE_PATH}/docker-compose.yml" $@
    ;;
esac