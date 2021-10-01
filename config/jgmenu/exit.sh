#!/usr/bin/env bash

# exit script for Openbox and i3wm

wm_ob=`pgrep -x openbox`
wm_i3=`pgrep -x i3`

if [[ -n $wm_ob ]]; then
    openbox --exit
elif [[ -n $wm_i3 ]]; then
    i3-msg "exit"
fi

