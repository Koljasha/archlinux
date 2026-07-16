#!/usr/bin/env bash

#
# set screen brightness temperature
#

declare -a options=(
"2500\0icon\x1fvideo-display"
"3000\0icon\x1fvideo-display"
"3500\0icon\x1fvideo-display"
"4000\0icon\x1fvideo-display"
"4500\0icon\x1fvideo-display"
"5000\0icon\x1fvideo-display"
"5500\0icon\x1fvideo-display"
"6000\0icon\x1fvideo-display"
"6500\0icon\x1fvideo-display"
)

brightness=`printf '%b\n' "${options[@]}" \
            | rofi -dmenu -l 3 -select $brightness -p Temperature`
            # change to dmenu -> move up rofi
            # | dmenu -b -i -p Brightness:`
if [[ $brightness == "" ]]; then
    exit 0
fi

/usr/bin/redshift -P -O $brightness

