#!/bin/bash

# https://github.com/Eredarion/dotfiles/blob/master/bin/screenshot

SCREENSHOTS_DIR="$HOME/screenshots"
TIMESTAMP="$(date +%Y.%m.%d-%H:%M:%S)"
FILENAME=$SCREENSHOTS_DIR/$TIMESTAMP.png
PHOTO_ICON_PATH="$HOME/.config/awesome/themes/skyfall/icons/screenshot.png"
NOTIFY_TIME=4000

# -u option hides cursor
# -m option changes the compression level
#   -m 3 takes the shot faster but the file size is slightly bigger

if [[ "$1" = "-s" ]]; then
    # Area/window selection.
    notify-send 'Select area to capture.' --urgency low -i $PHOTO_ICON_PATH
    maim -u -m 3 -s $FILENAME
    if [[ "$?" = "0" ]]; then
        notify-send 'Screenshot!~' "Name: <span color=\"#EA9090\">$TIMESTAMP.png</span>  " \
          -t $NOTIFY_TIME --urgency low -i $PHOTO_ICON_PATH
        xclip -selection clipboard "$FILENAME" -t image/png
    fi
    # TODO: every option should have to possibily to
    # either copy to clipboard or open with image viewer
    # TODO: also there should be an option to not save the image an directly open in in viewer
    # or copy it to clipboard
    if [[ "$2" = "-o" ]]; then
      sxiv "$FILENAME"
    fi
elif [[ "$1" = "-c" ]]; then
    notify-send 'Select area to copy to clipboard.' --urgency low -i $PHOTO_ICON_PATH
    # Copy selection to clipboard
    #maim -u -m 3 -s | xclip -selection clipboard -t image/png
    maim -u -m 3 -s /tmp/maim_clipboard
    if [[ "$?" = "0" ]]; then
        xclip -selection clipboard -t image/png /tmp/maim_clipboard
        notify-send "Copied selection to clipboard." --urgency low -i $PHOTO_ICON_PATH
        rm /tmp/maim_clipboard
    fi
else
    # Full screenshot
    notify-send 'Screenshot!~' \
            "Name: <span color=\"#EA9090\">$TIMESTAMP.png</span>  " \
            -t $NOTIFY_TIME \
            --urgency low  \
            -i $PHOTO_ICON_PATH \
            && sleep 0.5
    maim -u -m 3 $FILENAME
fi 

