# defined smb.service start|stop|status
#
function samba-server --description 'smb.service start|stop|status'
        if test \( (count $argv) -eq 1 \) -a \( "$argv[1]" = 'start' \)
                sudo systemctl start smb.service
        else if test \( (count $argv) -eq 1 \) -a \( "$argv[1]" = 'stop' \)
                sudo systemctl stop smb.service
        else if test \( (count $argv) -eq 1 \) -a \( "$argv[1]" = 'status' \)
            systemctl status smb.service
        else
            echo "Use: samba-server start|stop|status"
        end
end

