#!/usr/bin/env bash

#
# show and start|stop wireguard service
#
# !!! Need wireguard config file: /etc/wireguard/wg0.conf !!!
#

status=`sudo wg`

if (( $# == 0 )); then
    if [[ $status == "" ]]; then
        echo "<span foreground='#99d3ff'> WG</span>"
    else
        echo "<span foreground='#55aa55'> WG</span>"
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

