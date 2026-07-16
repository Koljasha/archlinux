#!/usr/bin/env bash

#
# Combined power control and window manager exit script
# Usage: 
#   ./power.sh        - shows power menu (full menu)
#   ./power.sh exit   - just exits WM (for jgmenu)
#

# Function to exit window manager
exit_wm() {
    if [[ -n $(pgrep -x openbox) ]]; then
        openbox --exit
    elif [[ -n $(pgrep -x i3) ]]; then
        i3-msg "exit"
    elif [[ -n $(pgrep -x qtile) ]]; then
        qtile cmd-obj -o cmd -f shutdown
    fi
}

# If first argument is "exit" - just exit WM
if [[ "$1" == "exit" ]]; then
    exit_wm
    exit 0
fi

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
                exit_wm
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

