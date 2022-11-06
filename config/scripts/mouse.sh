#!/usr/bin/env bash

#
# set mouse speed
#

if (( $# == 0 )); then
    echo "Error: No args"
    echo "$ ./mouse.sh <name> [<speed>]"
    exit 2
fi

mouse_name=$1
id=`xinput list | grep "$mouse_name" | head -n1 | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`

# show mouse speed
if (( $# == 1 )); then
    xinput --list-props $id | grep "libinput Accel Speed"
    exit 0
fi

# set speed; range of [-1,1]
speed=$2
xinput --set-prop $id 'libinput Accel Speed' $speed

