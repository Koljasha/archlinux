# запуск|остановка|статус smb.service
#
function samba-server --description 'запуск|остановка|статус smb.service'
    if test (count $argv) -ne 1
        echo "Использование: samba-server start|stop|status"
        return
    end
    switch $argv[1]
        case start
            sudo systemctl start smb.service
        case stop
            sudo systemctl stop smb.service
        case status
            systemctl status smb.service
        case '*'
            echo "Использование: samba-server start|stop|status"
    end
end
