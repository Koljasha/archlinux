#!/usr/bin/env bash

#
# volume control with dmenu|rofi
#

###
# round Volume for past in rofi -select
###
volume=`pactl list sinks | grep "Volume: front-" | cut -d'/' -f2 | cut -d'%' -f1 | sed 's/^[[:space:]]*//' \
        | awk '{ if ($1 < 10) print "10"; else if ($1 > 100) print "100"; else print $1 }'`

checker=`echo $volume | awk '{ print $1/10 }'| grep -o "\."`

if [[ $checker == '.' ]]; then
    integer=`echo $volume | awk '{ print $1/10 }'| cut -d'.' -f1`
    fractional=`echo $volume | awk '{ print $1/10 }'| cut -d'.' -f2`
    case $fractional in
        1|2)
            volume="${integer}0"
            ;;
        3|4|5|6|7)
            volume="${integer}5"
            ;;
        8|9)
            integer=$((integer+1))
            volume="${integer}0"
            ;;
        *)
            ;;
    esac
fi
###

volume=`echo -e "100\n95\n90\n85\n80\n75\n70\n65\n60\n55\n50\n45\n40\n35\n30\n25\n20\n15\n10\nMute" \
        | rofi -dmenu -l 7 -select $volume -i -p Volume`
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

