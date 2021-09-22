# defined openvpn-client.service start|stop
#
# !!! Need openvpn config file: /etc/openvpn/client/openvpn.conf !!!
#
function openvpn-client.service --description 'openvpn-client.service start|stop'
    if test -z (pgrep -x openvpn)
        sudo systemctl start openvpn-client@openvpn
    else
        sudo systemctl stop openvpn-client@openvpn
    end
end

