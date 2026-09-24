#!/usr/bin/env bash

#
# переключение рабочих столов | перемещение на рабочий стол
#

# текущий рабочий стол
# if [[ -n $(pgrep -f '^/usr/bin/python /usr/bin/qtile') ]]; then
if [[ -n $(pgrep -x qtile) ]]; then
    workspaces=`qtile cmd-obj -o group -f info | grep 'label' | cut -d: -f2 | cut -d"\"" -f2`
elif [[ -n $(pgrep -x i3) ]]; then
    workspaces=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2 | cut -d: -f1`
else
    exit 2
fi

declare -a options=(
"1\0icon\x1fvideo-display"
"2\0icon\x1fvideo-display"
"3\0icon\x1fvideo-display"
"4\0icon\x1fvideo-display"
"5\0icon\x1fvideo-display"
"6\0icon\x1fvideo-display"
"7\0icon\x1fvideo-display"
"8\0icon\x1fvideo-display"
"9\0icon\x1fvideo-display"
"10\0icon\x1fvideo-display"
)

# переключаем рабочие столы
if (( $# == 1 )) && [[ $1 == 'change' ]]; then
    workspaces=`printf '%b\n' "${options[@]}" \
                | rofi -dmenu -l 3 -select $workspaces -p Workspaces 2>/dev/null`
                # смена на dmenu -> переместить выше rofi
                # | dmenu -b -i -p Workspaces:`
    if [[ $workspaces == '10' ]]; then
        workspaces='0'
    fi
    xdotool key --clearmodifiers super+$workspaces
# перемещаем на рабочий стол
elif (( $# == 1 )) && [[ $1 == 'move' ]]; then
    workspaces=`printf '%b\n' "${options[@]}" \
                | rofi -dmenu -l 3 -select $workspaces -p "Move to Workspaces" 2>/dev/null`
                # смена на dmenu -> переместить выше rofi
                # | dmenu -b -i -p 'Move to Workspaces:'`
    if [[ $workspaces == '10' ]]; then
        workspaces='0'
    fi
    xdotool key --clearmodifiers super+shift+$workspaces
else
    echo 'Error: Invalid arguments [ change | move ]'
    exit 2
fi

