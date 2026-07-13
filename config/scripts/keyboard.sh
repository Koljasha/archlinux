#!/usr/bin/env bash

#
# show and change keyboard layout
#

if [[ $1 != "change" ]]; then
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        # посмотреть cat /sys/class/leds/input*::scrolllock/brightness
        led=`cat /sys/class/leds/input4::scrolllock/brightness`
        if [[ $led == '1' ]]; then
            echo 'ru'
        else
            echo 'en'
        fi
    else
        echo $(xkb-switch)
    fi
else
    xkb-switch --next
fi

