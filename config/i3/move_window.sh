#!/usr/bin/env bash

# Перемещаем текущее окно на предыдущий|следующий рабочий стол

motion=$1
IFS=$'\n'

workspaces=(`grep 'set $workspace' ~/.config/i3/config | cut -d"\"" -f2`)
current=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2`

# Получаем индекс текущего рабочего стола
for (( i=0; i <= ${#workspaces[@]}-1; i++ )); do
    if [[ "$current" == "${workspaces[$i]}" ]]; then
        index=$i
        break
    fi
done

# Получаем индекс рабочего стола для перемещения
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

