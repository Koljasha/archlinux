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

########################################

#
# show:
# $ ./change_brightness
#
# change (after 1 only min 0.1):
# $ ./change_brightness +0.05 or $ ./change_brightness -0.05
#
# set brightness:
# ./change_brightness 0.80
#

# brightness=`xrandr --verbose | grep -i brightness | cut -d':' -f2 | cut -c2-`

# if (( $# == 0 )); then
    # echo $brightness | awk '{ print $1*100"%" }'
    # exit 0
# fi

# params=`echo $1`

# operator=`echo $params | cut -c1`
# value=`echo $params | cut -c2-`

# if [[ "$operator" == "+" ]]; then
    # brightness=`echo "$brightness $value" | awk '{ print $1+$2 }'`
# elif [[ "$operator" == "-" ]]; then
    # brightness=`echo "$brightness $value" | awk '{ print $1-$2 }'`
# else
    # brightness=`echo $params`
# fi

# xrandr --output eDP-1 --brightness $brightness

