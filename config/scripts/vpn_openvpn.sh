#!/usr/bin/env bash

#
# show and start|stop openvpn service
#
# !!! Need openvpn config file: /etc/openvpn/client/openvpn.conf !!!
#

status=`pgrep -x openvpn`

if (( $# == 0 )); then
    if [[ -z $status ]]; then
        if [[ -n $(pgrep -x polybar) ]]; then
            echo "%{F#99d3ff}%{u#99d3ff}%{+u}  VPN%{u-}%{F-}"
        else
            echo "<span foreground='#99d3ff'> VPN</span>"
        fi
    else
        if [[ -n $(pgrep -x polybar) ]]; then
            echo "%{F#55aa55}%{u#55aa55}%{+u}  VPN%{u-}%{F-}"
        else
            echo "<span foreground='#55aa55'> VPN</span>"
        fi
    fi
    exit 0
fi

if [[ $1 == 'change' ]]; then
    if [[ -z $status ]]; then
        sudo systemctl start openvpn-client@openvpn
    else
        sudo systemctl stop openvpn-client@openvpn
    fi
fi

