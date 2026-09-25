#
# Настройки Fish
#

# не показывать приветственное сообщение
set fish_greeting

# vi-подобные привязки, наследующие emacs-подобные
function fish_hybrid_key_bindings \
    --description "Vi-привязки, наследующие emacs-привязки"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings

# сохранить текущий каталог (нужно для тайловых менеджеров вроде i3, qtile)
function prompt_command \
    --on-event fish_prompt \
    --description 'сохранить текущий каталог'
    pwd > /tmp/whereami
end


# псевдонимы для стандартных команд
alias ll="ls -lahv --group-directories-first"
alias grep="grep --color=auto"
alias cp="cp -av"
alias mv="mv -v"
alias rm="rm -v"
alias view="vim -R"

# псевдонимы для дополнительных команд
alias ll="eza -lahg --group-directories-first"
alias rm="trash -v"

alias rsync="rsync -avP"
alias fd="fd --hidden --follow --no-ignore"
alias rg="rg --hidden --follow --no-ignore --ignore-case"

# псевдонимы для bat|bat-extras
alias cat="bat"
alias ccat="bat -pp"

alias less="bat --pager 'less -iR'"
alias lless="/usr/bin/less -i"

alias grep="batgrep --ignore-case"
alias ggrep="/usr/bin/grep --color=auto"
alias rgrep="rg"

alias man="batman"
alias diff="batdiff --delta"

alias pass-gen="pwgen -s 45 -N 5 -1 -y -r'{}()[]\\`|'"

# псевдоним для Debian apt|nala
if test -f /usr/bin/apt
    if test -f /usr/bin/nala
        alias apt.update="sudo nala upgrade && sudo nala autopurge"
    else
        alias apt.update="sudo apt update && sudo apt full-upgrade -V && sudo apt autoremove -V"
    end
end

# псевдоним для grub-update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#
# VPN
#

# псевдонимы для Sing-Box
function sb-up --description 'запустить sing-box, если не активен'
    if test (systemctl is-active sing-box.service) != "active"
        sudo systemctl start sing-box.service
    else
        echo "уже активен"
    end
end
function sb-down --description 'остановить sing-box, если активен'
    if test (systemctl is-active sing-box.service) = "active"
        sudo systemctl stop sing-box.service
    else
        echo "уже неактивен"
    end
end
function sb-status --description 'показать статус sing-box'
    systemctl is-active sing-box.service
end

# псевдонимы для OpenVpn версии 3
alias vpn-up="openvpn3 session-start --config $argv[1]"
alias vpn-down="openvpn3 session-manage --disconnect --config $argv[1]"
alias vpn-status="openvpn3 sessions-list"

# псевдонимы для WireGuard
# alias wg-up="sudo wg-quick up wg0"
# alias wg-down="sudo wg-quick down wg0"
# function wg-status --description 'показать статус WireGuard'
    # if test -z (sudo wg | sed -n 1p)
        # echo 'Нет соединения WireGuard'
    # else
        # echo -e 'Подключение WireGuard\n'
        # sudo wg
    # end
# end

# псевдонимы для OpenVpn версии 2 из NetworkManager
# alias vpn-up="nmcli connection up $argv[1]"
# alias vpn-down="nmcli connection down $argv[1]"
# function vpn-status --description 'показать статус OpenVpn'
    # nmcli connection show | /usr/bin/grep vpn
# end


# псевдоним для distrobox
# alias distrobox_create="distrobox create --volume /run/mount/storage:/run/mount/storage:rw"

