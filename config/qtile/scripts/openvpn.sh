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
        echo "<span foreground='#99d3ff'> VPN</span>"
    else
        echo "<span foreground='#55aa55'> VPN</span>"
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

