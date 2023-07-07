#
# Fish settings
#

# not display a welcome message
set fish_greeting

# Vi-style bindings that inherit emacs-style
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


# aliases default
alias ll="ls -lahv --group-directories-first"
alias grep="grep --color=auto"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"


# aliases additionally
alias cat="bat"
alias ccat="bat -pp"
alias less="bat --pager 'less -iR'"

alias fd="fd --hidden --no-ignore"
alias rg="rg --hidden --no-ignore --ignore-case"


# aliases WireGuard, Vpn
# alias wg-up="sudo wg-quick up wg0"
# alias wg-down="sudo wg-quick down wg0"
# function wg-status --description 'show WireGuard status'
    # if test -z (sudo wg | sed -n 1p)
        # echo 'No WireGuard Connection'
    # else
        # echo -e 'WireGuard Connect\n'
        # sudo wg
    # end
# end

# alias vpn-up="nmcli connection up OpenVpn"
# alias vpn-down="nmcli connection down OpenVpn"
# function vpn-status --description 'show OpenVpn status'
    # set -l conn (nmcli connection show | grep vpn | awk '{print $4}')
    # if test -z $conn; or test $conn = '--'
        # echo 'No OpenVpn Connection'
    # else
        # echo -e 'OpenVpn Connect\n'
        # nmcli connection show
    # end
# end

