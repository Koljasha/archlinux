#!/usr/bin/env bash

#
# show updates in Bar
# !!! -> need yay -Sy as timer or cron
#

if [[ -n $(pgrep -x polybar) ]]; then
    # for Polybar (Openbox, i3wm)
    if (( $# == 0 )); then
        yay=`yay -Qu | wc -l`

        if (( $yay != 0 )); then
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
    # for Qtile
    terminator -x yay -Su --removemake --cleanafter
    qtile cmd-obj -o cmd -f reload_config
fi

