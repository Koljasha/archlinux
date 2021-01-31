# defined smb.service start
#
function smb.start --description 'start smb service'
     sudo systemctl start smb.service
end
