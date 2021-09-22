# defined smb.service start|stop
#
function smb.service --description 'smb.service start|stop'
        if test -z (pgrep -x smbd)
            sudo systemctl start smb.service
        else
            sudo systemctl stop smb.service
        end
end

