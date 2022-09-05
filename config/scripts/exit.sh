#!/usr/bin/env bash

#
# exit script for Openbox, i3wm, Qtile
#

if [[ -n $(pgrep -x openbox) ]]; then
    openbox --exit
elif [[ -n $(pgrep -x i3) ]]; then
    i3-msg "exit"
elif [[ -n $(pgrep -f '^/usr/bin/python /usr/bin/qtile') ]]; then
    qtile cmd-obj -o cmd -f shutdown
fi

