#!/bin/bash

# auto reload browser when specified file has changed
# usage: ./autoreload.sh -t "localhost:8000" ./index.html

usage() {
  cat <<EOF
usage $(basename $0) <[options]> <file>
Options:
          -t, --title     (part of) window's title
          -h, --help      show this help
EOF
}

refresh_window() {
  local title=$1
  xdotool search --onlyvisible --name "${title}.*firefox" | head -1 |
    xargs -I {} xdotool key --window {} 'CTRL+r'
}

# https://stackoverflow.com/a/12523979
while getopts "t:h-" OPTION; do
  case "$OPTION" in
    t ) TITLE=$OPTARG  ;;
    h ) usage ; exit   ;;
    - ) [ $OPTIND -ge 1 ] && optind=$(expr $OPTIND - 1 ) || optind=$OPTIND
        eval OPTION="\$$optind"
        OPTARG=$(echo $OPTION | cut -d'=' -f2)
        OPTION=$(echo $OPTION | cut -d'=' -f1)
        case $OPTION in
          --title ) TITLE=$OPTARG  ;;
          --help  ) usage; exit    ;;
          *       ) usage; exit 1  ;;
        esac
        OPTIND=1
        shift
        ;;
    * ) usage; exit 1;;
  esac
done

FILES=${@:$OPTIND:1}
TIME_FORMAT='%F %H:%M'
OUTPUT_FORMAT='%T Event(s): %e fired for file: %w'

while inotifywait --timefmt "${TIME_FORMAT}" -e 'move_self' --format "${OUTPUT_FORMAT}" "$FILES"; do
  refresh_window "$TITLE"
done
