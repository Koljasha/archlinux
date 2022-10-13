#!/usr/bin/env bash

#
# power control with dmenu|rofi
#

declare -a options=(
"Exit"
"Suspend"
"Hibernate"
"Reboot"
"PowerOff"
)

choice=`printf '%s\n' "${options[@]}" \
        | rofi -dmenu -i -l 2 -p Exit`
        # | dmenu -b -i -p Exit:`

case $choice in
        Exit)
                ~/.config/scripts/exit.sh
                ;;
        Suspend)
                systemctl -i suspend
                ;;
        Hibernate)
                systemctl -i hibernate
                ;;
        Reboot)
                systemctl -i reboot
                ;;
        PowerOff)
                systemctl -i poweroff
                ;;
        *)
                ;;
esac

