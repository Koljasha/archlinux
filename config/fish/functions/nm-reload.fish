# reload network connection
#
function nm-reload --description 'reload network connection'
    nmcli networking connectivity
    nmcli networking off
    sleep 1
    nmcli networking connectivity
    nmcli networking on
    sleep 7
    nmcli networking connectivity
end

