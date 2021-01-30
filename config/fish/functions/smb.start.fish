# defined smb.service start
#
function smb.start --wraps='sudo systemctl start smb.service' --description 'alias smb.start sudo systemctl start smb.service'
     sudo systemctl start smb.service $argv;
end
