#!/bin/bash

# move all folders in a source directory into
# a destination directory using rsync. logs into journal

function log_info() {
    echo "${1}" | systemd-cat -t "mvdl" -p info
}

function log_error() {
    echo "$1" | systemd-cat -t "mvdl" -p emerg &&
      dunstify "ERROR" "$1"
}

SOURCE_DIRECTORY="$1"
DESTINATION_DIRECTORY="$2"

# TODO: add error logging
[ ! -d "$SOURCE_DIRECTORY" ] || [ ! -d "$DESTINATION_DIRECTORY" ] && exit

UNPACK_PREFIX="_UNPACK"
FAILED_PREFIX="_FAILED"
readarray -d '' DIRECTORIES < <(find "$SOURCE_DIRECTORY" -mindepth 1 -maxdepth 1 -type d \
  -not \( -name "${UNPACK_PREFIX}*" -or -name "${FAILED_PREFIX}*" \) -print0)

log_info "Start moving ${#DIRECTORIES[@]} directories to ${DESTINATION_DIRECTORY}"
for directory in "${DIRECTORIES[@]}"; do
  rsync -ah --info=progress2 --append-verify --remove-source-files --stats "$directory" "$DESTINATION_DIRECTORY" &&
    log_info "Successfully moved $(basename $directory)" && find "$directory" -type d -empty -print -delete || 
    log_error "Error moving ${directory}" 
done
