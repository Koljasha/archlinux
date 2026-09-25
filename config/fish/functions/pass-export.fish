# экспорт паролей pass
#
function pass-export --description 'экспорт паролей pass'
    if test -d ~/.password-store
        mkdir passwords
        cp -r ~/.password-store/. passwords/
        tar czvf pass.tar.gz passwords/
        gpg -r $(whoami) -e pass.tar.gz
        rm -rf pass.tar.gz passwords/
        echo "Файл экспорта создан"

        # копирование в zip-источник
        #

        rm pass.tar.gz.gpg
    else
        echo "Нет хранилища pass"
    end
end

