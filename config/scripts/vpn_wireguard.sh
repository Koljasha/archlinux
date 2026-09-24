#!/usr/bin/env bash

#
# показываем и запускаем|останавливаем службу wireguard
#
# !!! Нужен конфиг wireguard: /etc/wireguard/wg0.conf !!!
#

status=$(sudo wg)

if (( $# == 0 )); then
    if [[ $status == "" ]]; then
        if [[ -n $(pgrep -x polybar) ]]; then
            echo "%{F#99d3ff}%{u#99d3ff}%{+u}  WG%{u-}%{F-}"
        else
            echo "<span foreground='#99d3ff'> WG</span>"
        fi
    else
        if [[ -n $(pgrep -x polybar) ]]; then
            echo "%{F#55aa55}%{u#55aa55}%{+u}  WG%{u-}%{F-}"
        else
            echo "<span foreground='#55aa55'> WG</span>"
        fi
    fi
    exit 0
fi

if [[ $1 == 'change' ]]; then
    if [[ $status == "" ]]; then
        sudo wg-quick up wg0
    else
        sudo wg-quick down wg0
    fi
fi

