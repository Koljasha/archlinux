#!/usr/bin/env bash

#
# show and set brightness
#

brightness=`brightnessctl | grep Current | cut -d'(' -f2 | cut -d'%' -f1`
if (( $# == 0 )); then
    echo "$brightness%"
    exit 0
fi

###
# round Brightness for past in rofi -select
###
checker=`echo $brightness | awk '{ print $1/10 }'| grep -o "\."`

if [[ $checker == '.' ]]; then
    integer=`echo $brightness | awk '{ print $1/10 }'| cut -d'.' -f1`
    fractional=`echo $brightness | awk '{ print $1/10 }'| cut -d'.' -f2`
    case $fractional in
        1|2|3|4)
            brightness="${integer}0"
            ;;
        5|6|7|8|9)
            integer=$((integer+1))
            brightness="${integer}0"
            ;;
        *)
            ;;
    esac
fi
###

if [[ $1 == 'change' ]]; then
    declare -a options=(
    "100\0icon\x1fvideo-display"
    "90\0icon\x1fvideo-display"
    "80\0icon\x1fvideo-display"
    "70\0icon\x1fvideo-display"
    "60\0icon\x1fvideo-display"
    "50\0icon\x1fvideo-display"
    "40\0icon\x1fvideo-display"
    "30\0icon\x1fvideo-display"
    "20\0icon\x1fvideo-display"
    "10\0icon\x1fvideo-display"
    )
    brightness=`printf '%b\n' "${options[@]}" \
                | rofi -dmenu -l 3 -select $brightness -p Brightness`
                # | dmenu -b -i -p Brightness:`
    if [[ $brightness == "" ]]; then
        exit 0
    fi
    brightnessctl set "$brightness%"
fi

