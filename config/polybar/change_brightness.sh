#!/bin/bash

#
# show:
# $ ./change_brightness
#
# set brightness (round):
# ./change_brightness change
#

brightness=`xrandr --verbose | grep -i brightness | cut -d':' -f2 | cut -c2- | awk '{ print $1*100 }'`
if (( $# == 0 )); then
    echo "$brightness%"
    exit 0
fi

if [[ $1 == 'change' ]]; then
    brightness=`zenity --scale --title="Яркость дисплея" --text="Установите яркость дисплея %" --value=$brightness --step=10 --min-value=10`
    if (( $? == 0 )); then
        brightness=`echo $brightness | awk '{ print $1/10 }' | awk '{ print ($0-int($0)<0.499)?int($0):int($0)+1 }' | awk '{ print $1/10 }'`
        xrandr --output eDP-1 --brightness $brightness
    fi
fi

