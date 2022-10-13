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

declare -a options=(
"100\0icon\x1faudio-volume-high"
"95\0icon\x1faudio-volume-high"
"90\0icon\x1faudio-volume-high"
"85\0icon\x1faudio-volume-high"
"80\0icon\x1faudio-volume-high"
"75\0icon\x1faudio-volume-high"
"70\0icon\x1faudio-volume-medium"
"65\0icon\x1faudio-volume-medium"
"60\0icon\x1faudio-volume-medium"
"55\0icon\x1faudio-volume-medium"
"50\0icon\x1faudio-volume-medium"
"45\0icon\x1faudio-volume-medium"
"40\0icon\x1faudio-volume-low"
"35\0icon\x1faudio-volume-low"
"30\0icon\x1faudio-volume-low"
"25\0icon\x1faudio-volume-low"
"20\0icon\x1faudio-volume-low"
"15\0icon\x1faudio-volume-low"
"10\0icon\x1faudio-volume-low"
"Mute\0icon\x1faudio-volume-off"
)
volume=`printf '%b\n' "${options[@]}" \
        | rofi -dmenu -l 6 -select $volume -i -p Volume`
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

