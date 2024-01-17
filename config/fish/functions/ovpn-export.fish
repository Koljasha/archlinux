# export openvpn keys
#
function ovpn-export --description 'export openvpn keys'

    gpg --decrypt ovpn.tar.gz.gpg > ovpn.tar.gz
    if test $status -eq 0
        rm -rf ovpn.tar.gz.gpg
        tar xvf ovpn.tar.gz

        tar czvf ovpn.tar.gz *.ovpn
        gpg -r $(whoami) -e ovpn.tar.gz

        rm -rf xvf ovpn.tar.gz
        rm -rf *.ovpn
        echo "Export file has been created"

    else
        echo "Invalid decryption"
    end
end

