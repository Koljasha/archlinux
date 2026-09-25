# экспорт SSH-ключей и конфигов
#
function ssh-export --description 'экспорт SSH-ключей и конфигов'
    if test -d ~/.ssh
        mkdir ssh_keys
        cp -r ~/.ssh/. ssh_keys/
        rm -rf ssh_keys/known_hosts*
        tar czvf ssh_keys.tar.gz ssh_keys/
        gpg -r $(whoami) -e ssh_keys.tar.gz
        rm -rf ssh_keys.tar.gz ssh_keys/
        echo "Файл экспорта создан"

        # копирование в zip-источник
        #

        rm ssh_keys.tar.gz.gpg
    else
        echo "Нет каталога SSH"
    end
end

