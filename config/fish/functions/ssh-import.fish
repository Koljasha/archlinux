# импорт SSH-ключей и конфигов
#
function ssh-import --description 'импорт SSH-ключей и конфигов'
    if test -f ssh_keys.tar.gz.gpg
        gpg --decrypt ssh_keys.tar.gz.gpg > ssh_keys.tar.gz
        if test $status -eq 0
            tar xvf ssh_keys.tar.gz
            if test -d ~/.ssh
                rm -rf ~/.ssh/*
            else
                mkdir ~/.ssh
                chmod 700 ~/.ssh
            end
            cp -r ssh_keys/. ~/.ssh/
            rm -rf ssh_keys.tar.* ssh_keys/
            echo "SSH-ключи импортированы"
        else
            echo "Ошибка расшифровки"
        end
    else
        echo "Нет файла импорта"
    end
end
