#!/usr/bin/env bash

# exit script for Openbox and i3wm

if [[ -n $(pgrep -x openbox) ]]; then
    openbox --exit
elif [[ -n $(pgrep -x i3) ]]; then
    i3-msg "exit"
elif [[ -n $(pgrep -x qtile) ]]; then
    qtile cmd-obj -o cmd -f shutdown
fi

