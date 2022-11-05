#!/usr/bin/env bash

#
#  set mouse speed
#

if [[ $1 == "" ]]; then
    echo "Error: No speed value"
    exit 2
fi

speed=$1 # range of [-1,1]

# for mouse Logitech M310
id=`xinput list | grep "M310" | head -n1 | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`

# set speed
xinput --set-prop $id 'libinput Accel Speed' $speed

# for check
# xinput --list-props $id

