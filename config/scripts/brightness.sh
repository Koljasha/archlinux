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
    brightness=`seq 10 10 100 | rofi -dmenu -l 10 -p Brightness`
    if (( $? == 0 )); then
        brightness=`echo $brightness | awk '{ print $1/10 }' | awk '{ print ($0-int($0)<0.499)?int($0):int($0)+1 }' | awk '{ if ($1 < 1) print "1"; else if ($1 > 10) print "10"; else print $0; }' | awk '{ print $1/10 }'`
        xrandr --output eDP1 --brightness $brightness
    fi
fi
