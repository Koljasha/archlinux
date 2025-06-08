# defined reflector.service start
#
function reflector-start --description 'reflector.service start'
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    sudo systemctl start reflector.service
end

