#!/usr/bin/env bash

if (( $# != 1 )); then
    echo "./menu_exit_openbox.sh reboot  or  ./menu_exit_openbox.sh poweroff  !!!"
    exit 0
fi

if [[ $1 == 'reboot' ]]; then
    zenity --question --no-wrap --title "Reboot PC" --text "Do you want to REBOOT your PC?" && systemctl -i reboot
elif [[ $1 == 'poweroff' ]]; then
    zenity --question --no-wrap --title "Power Off PC" --text "Do you want to POWER OFF your PC?" && systemctl -i poweroff
else
    echo "./menu_exit_openbox.sh reboot  or  ./menu_exit_openbox.sh poweroff  !!!"
fi

