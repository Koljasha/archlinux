# defined smb.service start
#
function smb.stop --description 'stop smb service'
     sudo systemctl stop smb.service
end
