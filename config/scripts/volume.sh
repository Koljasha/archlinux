#!/usr/bin/env bash

#
# volume control with dmenu|rofi
#

volume=`echo -e "Mute\n100\n95\n90\n85\n80\n75\n70\n65\n60\n55\n50\n45\n40\n35\n30\n25\n20\n15\n10\n5" \
        | rofi -dmenu -l 10 -select 75 -i -p Volume`
        # | dmenu -b -i -p Volume:`

if [[ $volume == "" ]]; then
        exit 0
fi

case $volume in
        Mute)
                pactl set-sink-mute 0 toggle
                ;;
        *)
                pactl set-sink-mute 0 false
                pactl set-sink-volume 0 $volume%
                ;;
esac

