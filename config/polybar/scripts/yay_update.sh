#!/usr/bin/env bash

#
# $ ./yay.sh
# $ ./yay.sh change
#
# !!! -> need yay -Sy as timer or cron
#

if (( $# == 0 )); then
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
    terminator -m -x ~/.config/polybar/scripts/yay_update.sh terminal

    exit 0
fi

if [[ $1 == 'terminal' ]]; then
    yay -Su --removemake --cleanafter
    polybar-msg cmd restart

    exit 0
fi

