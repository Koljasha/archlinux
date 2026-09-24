#!/usr/bin/env bash

#
# показываем обновления в панели
# !!! -> нужно yay -Sy как таймер или cron
#

if [[ -n $(pgrep -x polybar) ]]; then
    # для Polybar (Openbox, i3wm)
    if (( $# == 0 )); then
        yay=$(yay -Qu | wc -l)

        if (( yay != 0 )); then
            echo "%{F#ffb52a}%{u#ffb52a}%{+u}  $yay Updates%{u-}%{F-}"
        else
            echo "%{F#99d3ff}%{u#99d3ff}%{+u}  No Updates%{u-}%{F-}"
        fi

        exit 0
    fi

    if [[ $1 == 'change' ]]; then
        terminator -m -x yay -Su --removemake --cleanafter
        polybar-msg cmd restart
    fi
else
    # для Qtile
    terminator -x yay -Su --removemake --cleanafter
    qtile cmd-obj -o widget checkupdates -f force_update
    # qtile cmd-obj -o cmd -f reload_config
fi

