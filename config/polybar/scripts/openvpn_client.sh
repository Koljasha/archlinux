#!/usr/bin/env bash

#
# show:
# $ ./openvpn_client.sh
#
# openvpn-client.service start|stop:
# !!! Need openvpn config file: /etc/openvpn/client/openvpn.conf !!!
# $ ./openvpn_client.sh change
#

status=`pgrep -x openvpn`

if (( $# == 0 )); then
    if [[ -z $status ]]; then
        echo "%{F#99d3ff}%{u#99d3ff}%{+u}  VPN%{u-}%{F-}"
    else
        echo "%{F#55aa55}%{u#55aa55}%{+u}  VPN%{u-}%{F-}"
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
