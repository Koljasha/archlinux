#
# Fish settings
#

set fish_greeting

# save current directory (for i3 terminal)
prompt_command

alias ll="ls -lah"
alias grep="grep --color=auto"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

alias fd="fd --hidden --no-ignore"
alias rg="rg --hidden --no-ignore --ignore-case"

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

# alias openvpn-up="nmcli connection up OpenVpn"
# alias openvpn-down="nmcli connection down OpenVpn"
# alias openvpn-status="nmcli connection show"

