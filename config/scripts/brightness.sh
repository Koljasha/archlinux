#!/usr/bin/env bash

#
# show and set brightness
#

brightness=`xrandr --verbose | grep -i brightness | cut -d':' -f2 | cut -c2- | awk '{ print $1*100 }'`
if (( $# == 0 )); then
    echo "$brightness%"
    exit 0
fi

if [[ $1 == 'change' ]]; then
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
                # | dmenu -b -i -p Brightness:`
    if [[ $brightness == "" ]]; then
        exit 0
    fi
    brightness=`echo $brightness | awk '{ print $1/10 }' | awk '{ print ($0-int($0)<0.499)?int($0):int($0)+1 }' | awk '{ if ($1 < 1) print "1"; else if ($1 > 10) print "10"; else print $0; }' | awk '{ print $1/10 }'`
    xrandr --output eDP1 --brightness $brightness
fi

