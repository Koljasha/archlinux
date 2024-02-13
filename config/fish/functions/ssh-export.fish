# export ssh keys and configs
#
function ssh-export --description 'export ssh keys and configs'
    if test -d ~/.ssh
        mkdir ssh_keys
        cp -r ~/.ssh/. ssh_keys/
        rm -rf ssh_keys/known_hosts*
        tar czvf ssh_keys.tar.gz ssh_keys/
        gpg -r $(whoami) -e ssh_keys.tar.gz
        rm -rf ssh_keys.tar.gz ssh_keys/
        echo "Export file has been created"

        # copy to zip source
        #

        rm ssh_keys.tar.gz.gpg
    else
        echo "No SSH folder"
    end
end

