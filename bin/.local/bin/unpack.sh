#!/bin/bash

# unpack files within folders like '...{{password}}'

COLOR_RED='\033[1;31m'
COLOR_GREEN='\033[1;32m'
COLOR_RESET='\033[0m'

# TODO: folders without {{}}
# TODO: remove .par2 and .rar files
# TODO: integrate par2verify and par2repair

log_info() {
  printf "[${COLOR_GREEN}+${COLOR_RESET}] ${1}\n"
}

log_error() {
  printf "[${COLOR_RED}-${COLOR_RESET}] ${1}\n"
}

for archive in $(find . -type f \( -wholename './*{{*}}/*.part01.rar' -o -wholename './*{{*}}/*.part1.rar' \)); do
  echo "$archive"
  PASSWORD=$(echo "$archive" | grep -E -o '\{\{(.*)\}\}' | tr -d '{}')
  [ -z "$PASSWORD" ] && continue
  7z x "$archive" -aoa -p"${PASSWORD}" -o$(dirname "$archive") > /dev/null 2>> errors.log
  if [ $? -ne 0 ]; then
    log_error "${archive} failed with password ${PASSWORD}"
    continue
  fi

  find $(dirname "$archive") -type f \( -name "*.rar" -o -name "*.par2" \) -delete -print
  mv $(dirname "$archive") $(dirname "$archive" | sed 's/{{.*//')
  log_info "${archive} success"
done
