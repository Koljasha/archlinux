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
    xinput list-props $id | grep "libinput Accel Speed"
    exit 0
fi

# set speed; range of [-1,1]
speed=$2
xinput set-prop $id 'libinput Accel Speed' $speed


#####
# do emulation of middle button by pressing the left and right buttons
# setting up the Back command for this combination

# xinput get-button-map $id
# xinput set-prop $id "libinput Middle Emulation Enabled" 1
# xinput set-button-map $id 1 8 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

#####
# make the sticking of button left on the Forward button

# xinput set-prop $id "libinput Drag Lock Buttons" 9 1

#####

