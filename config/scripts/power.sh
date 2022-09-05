#!/usr/bin/env bash

#
# power control with dmenu|rofi
#

declare -a options=(
"Exit"
"Reboot"
"PowerOff"
)

choice=`printf '%s\n' "${options[@]}" \
        | rofi -dmenu -i -l 3 -p Exit`
        # | dmenu -b -i -p Exit:`

case $choice in
        Exit)
                ~/.config/scripts/exit.sh
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

