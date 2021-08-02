#!/bin/bash

# !!! Need openvpn config file: /etc/openvpn/client/openvpn.conf !!!

status=`pgrep -x openvpn`
if [[ -z $status ]]; then
    sudo systemctl start openvpn-client@openvpn
else
    sudo systemctl stop openvpn-client@openvpn
fi

