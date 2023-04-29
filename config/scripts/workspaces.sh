#!/usr/bin/env bash

#
# change Workspaces | move to Workspaces
#

# current Workspaces
if [[ -n $(pgrep -f '^/usr/bin/python /usr/bin/qtile') ]]; then
    workspaces=`qtile cmd-obj -o group -f info | grep 'label' | cut -d: -f2 | cut -d\' -f2`
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

# change Workspaces
if (( $# == 1 )) && [[ $1 == 'change' ]]; then
    workspaces=`printf '%b\n' "${options[@]}" \
                | rofi -dmenu -l 3 -select $workspaces -p Workspaces 2>/dev/null`
                # change to dmenu -> move up rofi
                # | dmenu -b -i -p Workspaces:`
    if [[ $workspaces == '10' ]]; then
        workspaces='0'
    fi
    xdotool key --clearmodifiers super+$workspaces
# move to Workspaces
elif (( $# == 1 )) && [[ $1 == 'move' ]]; then
    workspaces=`printf '%b\n' "${options[@]}" \
                | rofi -dmenu -l 3 -select $workspaces -p "Move to Workspaces" 2>/dev/null`
                # change to dmenu -> move up rofi
                # | dmenu -b -i -p 'Move to Workspaces:'`
    if [[ $workspaces == '10' ]]; then
        workspaces='0'
    fi
    xdotool key --clearmodifiers super+shift+$workspaces
else
    echo 'Error: Invalid arguments [ change | move ]'
    exit 2
fi

