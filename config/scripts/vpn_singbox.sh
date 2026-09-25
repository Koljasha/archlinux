#!/usr/bin/env bash

#
# показываем и запускаем|останавливаем службу sing-box
#

status=$(systemctl is-active sing-box.service)

if (( $# == 0 )); then
    if [[ $status != "active" ]]; then
        if [[ -n $(pgrep -x polybar) ]]; then
            echo "%{F#99d3ff}%{u#99d3ff}%{+u}  SB%{u-}%{F-}"
        else
            echo "<span foreground='#99d3ff'> SB</span>"
        fi
    else
        if [[ -n $(pgrep -x polybar) ]]; then
            echo "%{F#55aa55}%{u#55aa55}%{+u}  SB%{u-}%{F-}"
        else
            echo "<span foreground='#55aa55'> SB</span>"
        fi
    fi
    exit 0
fi

if [[ $1 == 'change' ]]; then
    if [[ $status != "active" ]]; then
        sudo systemctl start sing-box.service
    else
        sudo systemctl stop sing-box.service
    fi
fi

