#!/usr/bin/env bash

#
# volume control with dmenu|rofi
#

# show Volume
if (( $# == 0 )); then
    mute=`pactl get-sink-mute 0 | cut -d' ' -f2`
    if [[ "$mute" == "yes" ]]; then
        echo "Muted"
        exit 0
    fi
    volume=`pactl get-sink-volume 0 | grep -oE '[0-9]{1,3}%' | head -1`
    echo "$volume"
    exit 0
fi

if [[ $1 != 'change' ]]; then
    echo 'Error: Invalid arguments [ change ]'
    exit 2
fi

###
# round Volume for past in rofi -select
#
# substring - ${string:position:length}
# length - ${#string}
###
volume=`pactl get-sink-volume 0 | grep -oE '[0-9]{1,3}%' | head -1 | cut -d'%' -f1 \
        | awk '{ if ($1 < 10) print "10"; else if ($1 > 100) print "100"; else print $1 }'`

last=${volume: -1:1}
prelast=${volume: -2:1}
other=${volume:0:${#volume}-2}
case $last in
    1|2)
        volume="${other}${prelast}0"
        ;;
    3|4|5|6|7)
        volume="${other}${prelast}5"
        ;;
    8|9)
        prelast=$((prelast+1))
        volume="${other}${prelast}0"
        ;;
    *)
        ;;
esac
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
        # change to dmenu -> move up rofi
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

