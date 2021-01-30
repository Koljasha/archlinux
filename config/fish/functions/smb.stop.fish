# defined smb.service stop
#
function smb.stop --wraps='sudo systemctl stop smb.service' --description 'alias smb.stop sudo systemctl stop smb.service'
     sudo systemctl stop smb.service $argv;
end
