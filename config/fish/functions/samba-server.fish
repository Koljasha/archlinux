# defined smb.service start|stop|status
#
function samba-server --description 'smb.service start|stop|status'
        if test \( (count $argv) -eq 1 \) -a \( "$argv[1]" = 'status' \)
            systemctl status smb.service
        else
            if test -z (pgrep -x smbd)
                sudo systemctl start smb.service
            else
                sudo systemctl stop smb.service
            end
        end
end

