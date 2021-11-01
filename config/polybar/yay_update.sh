#!/usr/bin/env bash

#
# show:
# $ ./yay.sh
#
# $ ./yay.sh change
#

if (( $# == 0 )); then
    sudo pacman -Sy 1>/dev/null

    yay=`yay -Qu | wc -l`
    arch=`pacman -Qu | wc -l`
    aur=`echo $yay $arch | awk '{ print $1-$2 }'`
    data="Arch:$arch | Aur:$aur"

    if (( $yay != 0 )); then
        echo "%{F#ffb52a}%{u#ffb52a}%{+u}  $data%{u-}%{F-}"
    else
        echo "%{F#99d3ff}%{u#99d3ff}%{+u}  $data%{u-}%{F-}"
    fi
    exit 0
fi

if [[ $1 == 'change' ]]; then
    echo "%{F#55aa55}%{u#55aa55}%{+u}  Update%{u-}%{F-}"
    terminator -m -x ~/.config/polybar/yay_update.sh terminal
    exit 0
fi

if [[ $1 == 'terminal' ]]; then
    yay
    polybar-msg hook yay_update 1
    exit 0
fi

