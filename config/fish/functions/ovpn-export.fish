# export openvpn keys
#
# put new-vpn.ovpn and ovpn.tar.gz.gpg to folder where run command
#
function ovpn-export --description 'export openvpn keys'
    if test -f ovpn.tar.gz.gpg
        gpg --decrypt ovpn.tar.gz.gpg > ovpn.tar.gz
        if test $status -eq 0
            rm -rf ovpn.tar.gz.gpg
            tar xvf ovpn.tar.gz

            tar czvf ovpn.tar.gz *.ovpn
            gpg -r $(whoami) -e ovpn.tar.gz

            rm -rf xvf ovpn.tar.gz
            rm -rf *.ovpn
            echo "Export file has been created"

            # copy to zip source
            #

            rm ovpn.tar.gz.gpg
        else
            echo "Invalid decryption"
        end
    else
        echo "No file: ovpn.tar.gz.gpg"
    end
end

