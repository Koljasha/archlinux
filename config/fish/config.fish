#
# Fish settings
#

# not display a welcome message
set fish_greeting

# vi-style bindings that inherit emacs-style
function fish_hybrid_key_bindings \
    --description "Vi-style bindings that inherit emacs-style"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings

# save current directory (it is necessary for tiling managers like i3, qtile)
function prompt_command \
    --on-event fish_prompt \
    --description 'save current directory'
    pwd > /tmp/whereami
end


# aliases for default commands
alias ll="ls -lahv --group-directories-first"
alias grep="grep --color=auto"
alias cp="cp -av"
alias mv="mv -v"
alias rm="rm -v"

# aliases for additional commands
alias ll="eza -lah --group-directories-first"
alias rsync="rsync -avP"
alias fd="fd --hidden --follow --no-ignore"
alias rg="rg --hidden --follow --no-ignore --ignore-case"

# aliases for bat|bat-extras
alias cat="bat"
alias ccat="bat -pp"

alias less="bat --pager 'less -iR'"
alias lless="/usr/bin/less -i"

alias grep="batgrep --ignore-case"
alias ggrep="/usr/bin/grep --color=auto"
alias rgrep="rg"

alias view="vim -R"

alias man="batman"
alias diff="batdiff --delta"

# alias for Debian apt|nala
if test -f /usr/bin/apt
    if test -f /usr/bin/nala
        alias apt.update="sudo nala upgrade && sudo nala autopurge"
    else
        alias apt.update="sudo apt update && sudo apt full-upgrade -V && sudo apt autoremove -V"
    end
end

# alias for grub-update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# aliases for WireGuard
alias wg-up="sudo wg-quick up wg0"
alias wg-down="sudo wg-quick down wg0"
function wg-status --description 'show WireGuard status'
    if test -z (sudo wg | sed -n 1p)
        echo 'No WireGuard Connection'
    else
        echo -e 'WireGuard Connect\n'
        sudo wg
    end
end

# aliases for OpenVpn version 3
alias vpn-up="openvpn3 session-start --config $argv[1]"
alias vpn-down="openvpn3 session-manage --disconnect --config $argv[1]"
alias vpn-status="openvpn3 sessions-list"

# aliases for OpenVpn version 2 from NetworkManager
# alias vpn-up="nmcli connection up $argv[1]"
# alias vpn-down="nmcli connection down $argv[1]"
# function vpn-status --description 'show OpenVpn status'
    # nmcli connection show | /usr/bin/grep vpn
# end


# aliases for distrobox
# alias distrobox_create="distrobox create --volume /run/mount/storage:/run/mount/storage:rw"

