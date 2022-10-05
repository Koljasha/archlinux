#!/usr/bin/env bash

#
# !!! -> need yay -Sy as timer or cron
#

if [[ -n $(pgrep -x polybar) ]]; then
    # for Polybar (Openbox, i3wm)
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
        terminator -m -x yay -Su --removemake --cleanafter
        polybar-msg cmd restart
    fi
else
    # for Qtile
    terminator -x yay -Su --removemake --cleanafter
    qtile cmd-obj -o cmd -f reload_config
fi

