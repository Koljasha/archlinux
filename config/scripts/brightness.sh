#!/usr/bin/env bash

#
# show and set brightness
#

brightness=`brightnessctl | grep Current | cut -d'(' -f2 | cut -d'%' -f1`
if (( $# == 0 )); then
    echo "$brightness%"
    exit 0
fi

###
# round Brightness for past in rofi -select
#
# substring - ${string:position:length}
# length - ${#string}
###
last=${brightness: -1:1}
prelast=${brightness: -2:1}
other=${brightness:0:${#brightness}-2}
case $last in
    1|2|3|4)
        brightness="${other}${prelast}0"
        ;;
    5|6|7|8|9)
        prelast=$((prelast+1))
        brightness="${other}${prelast}0"
        ;;
    *)
        ;;
esac
###

if [[ $1 != 'change' ]]; then
    echo 'Error: Invalid arguments [ change ]'
    exit 2
fi

# change brightness
declare -a options=(
"100\0icon\x1fvideo-display"
"90\0icon\x1fvideo-display"
"80\0icon\x1fvideo-display"
"70\0icon\x1fvideo-display"
"60\0icon\x1fvideo-display"
"50\0icon\x1fvideo-display"
"40\0icon\x1fvideo-display"
"30\0icon\x1fvideo-display"
"20\0icon\x1fvideo-display"
"10\0icon\x1fvideo-display"
)

brightness=`printf '%b\n' "${options[@]}" \
            | rofi -dmenu -l 3 -select $brightness -p Brightness`
            # change to dmenu -> move up rofi
            # | dmenu -b -i -p Brightness:`
if [[ $brightness == "" ]]; then
    exit 0
fi
brightnessctl set "$brightness%"

