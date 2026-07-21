#!/usr/bin/env bash

#
# some utils
#

if [[ $1 == 'desktop' ]]; then

    # collapse|expand applications on the desktop (for Openbox)

    status=`wmctrl -m | grep "showing the desktop" | awk -F ": " '{ print $2 }'`
    if [[ $status == "OFF" ]]; then
        wmctrl -k on
    else
        wmctrl -k off
    fi

    exit 0
fi

if [[ $1 == 'lock' ]]; then

    # display lock

    terminator --geometry=1920x1080 --fullscreen --execute cmatrix -Lrb &
    sleep 1
    i3lock -c 000000 -n
    killall cmatrix

    exit 0
fi

if [[ $1 == 'picom' ]]; then

    # restart Picom

    killall picom 2>/dev/null
    sleep 0.5
    picom -b

    exit 0
fi

