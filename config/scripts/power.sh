#!/usr/bin/env bash

#
# power control with dmenu|rofi
#

declare -a options=(
"Exit\0icon\x1fsystem-log-out"
"Suspend\0icon\x1fsystem-suspend"
"Reboot\0icon\x1fsystem-reboot"
"PowerOff\0icon\x1fsystem-shutdown"
)

choice=`printf '%b\n' "${options[@]}" \
        | rofi -dmenu -i -l 2 -p Exit`
        # | dmenu -b -i -p Exit:`

case $choice in
        Exit)
                ~/.config/scripts/exit.sh
                ;;
        Suspend)
                systemctl -i suspend
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

