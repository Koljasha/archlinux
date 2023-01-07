# export pass passwords
#
function pass-export --description 'export pass passwords'
    if test -d ~/.password-store
        tar czvf pass.tar.gz --directory=$(xdg-user-dir) .password-store/
        gpg -r $(whoami) -e pass.tar.gz
        rm -v pass.tar.gz
        echo "Export file has been created"
    else
        echo "No pass store"
    end
end

