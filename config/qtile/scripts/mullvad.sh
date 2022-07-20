#!/usr/bin/env bash

#
# show and start|stop Mullvad VPN
#

status=`mullvad status | grep Disconnected`

if (( $# == 0 )); then
    if [[ -n $status ]]; then
        echo "<span foreground='#99d3ff'> Mullvad</span>"
    else
        echo "<span foreground='#55aa55'> Mullvad</span>"
    fi
    exit 0
fi

if [[ $1 == 'change' ]]; then
    if [[ -n $status ]]; then
        mullvad connect
    else
        mullvad disconnect
    fi
fi

