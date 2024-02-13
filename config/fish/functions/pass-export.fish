# export pass passwords
#
function pass-export --description 'export pass passwords'
    if test -d ~/.password-store
        mkdir passwords
        cp -r ~/.password-store/. passwords/
        tar czvf pass.tar.gz passwords/
        gpg -r $(whoami) -e pass.tar.gz
        rm -rf pass.tar.gz passwords/
        echo "Export file has been created"

        # copy to zip source
        #

        rm pass.tar.gz.gpg
    else
        echo "No pass store"
    end
end

