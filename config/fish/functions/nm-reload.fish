# перезагрузить сетевое соединение
#
function nm-reload --description 'перезагрузить сетевое соединение'
    nmcli networking connectivity
    nmcli networking off
    sleep 1
    nmcli networking connectivity
    nmcli networking on
    sleep 7
    nmcli networking connectivity
end

