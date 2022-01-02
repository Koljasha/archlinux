#!/usr/bin/env bash

#
# run terminal in same working directory
#

WHEREAMI=$(cat /tmp/whereami)

if [[ $1 == 'alacritty' ]]; then
    if [[ -z $(pgrep -x alacritty) ]]; then
        alacritty --working-directory="$HOME"
    else
        alacritty --working-directory="$WHEREAMI"
    fi
elif [[ $1 == 'terminator' ]]; then
    if [[ -z $(pgrep -x terminator) ]]; then
        terminator --working-directory="$HOME"
    else
        terminator --working-directory="$WHEREAMI"
    fi
fi

