#!/usr/bin/env bash

#
# "sniper" mouse mode - slowing Accel Speed
# $1 - device name
#

if (( $# != 1 )); then
    echo '$1 - device name'
    exit 2
fi

name=$1

data=`grep -i "$name" /etc/X11/xorg.conf.d/*.conf | grep 'MatchProduct'`
filename=`echo "$data" | cut -d: -f1`
device=`echo "$data" | sed -E 's/^.*"(.*)"$/\1/'`

id=`xinput list | grep "$device" | head -n1 | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`

# different file with settings for every mouse
# accel_speed_default=`grep AccelSpeed "$filename" | sed -E 's/^.+".+" "(.+)"$/\1/'`
# echo $accel_speed_default

# one file for all mouse
line_num=`grep -n "$device" $filename | head -1 | cut -d: -f1`
accel_speed_default=`sed -n "${line_num},$ p" $filename | grep AccelSpeed | head -1 | sed -E 's/^.+".+" "(.+)"$/\1/'`

# xinput settings
accel_speed=`xinput list-props $id | grep 'libinput Accel Speed (' | sed -E 's/^.+:\s(-?[0-9]+\.[0-9]{2})[0-9]+/\1/'`

if [[ $accel_speed_default == $accel_speed ]]; then
    xinput set-prop $id "libinput Accel Speed" "-1.0"
else
    xinput set-prop $id "libinput Accel Speed" "$accel_speed_default"
fi

