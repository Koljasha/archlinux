#!/usr/bin/env bash

# move current window to prev|next workspace

motion=$1
IFS=$'\n'

workspaces=(`grep 'set $workspace' ~/.config/i3/config | cut -d"\"" -f2`)
current=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2`

# get index current workspace
for (( i=0; i <= ${#workspaces[@]}-1; i++ )); do
    if [[ "$current" == "${workspaces[$i]}" ]]; then
        index=$i
        break
    fi
done

# get index workspace to move
if [[ $motion == "left" ]]; then
    if (( $index == 0 )); then
        index=$((${#workspaces[@]}-1))
    else
        index=$((index-1))
    fi
elif  [[ $motion == "right" ]]; then
    if (( $index == $((${#workspaces[@]}-1)) )); then
        index=0
    else
        index=$((index+1))
    fi
else
    exit 2
fi

i3-msg move container to workspace ${workspaces[$index]} > /dev/null 2>&1
i3-msg workspace ${workspaces[$index]} > /dev/null 2>&1

