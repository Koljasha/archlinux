#!/usr/bin/env bash

#
# mouse utils
#

if [[ $1 == 'scroll_button' ]]; then

    # change mouse Scrolling Button
    # use with Kensington Expert to change window size in Qtile and i3wm

    id=`xinput list | grep pointer | grep -Ev 'Virtual|SINO' | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`
    state=`xinput list-props $id | grep 'Button Scrolling Button' | head -1 | cut -d: -f2 | tr -d "[:space:]"`

    # default state is 2

    if [[ $state == '2' ]]; then
        xinput set-prop $id 'libinput Button Scrolling Button' 3
    else
        xinput set-prop $id 'libinput Button Scrolling Button' 2
    fi

    exit 0
fi

if [[ $1 == 'left_right' ]]; then

    # change mouse left|right hand

    id=`xinput list | grep pointer | grep -Ev 'Virtual|SINO' | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`
    state=`xinput list-props $id | grep 'Left Handed Enabled' | head -1 | cut -d: -f2 | tr -d "[:space:]"`

    if [[ $state == '0' ]]; then
        xinput set-prop $id 'libinput Left Handed Enabled' 1
    else
        xinput set-prop $id 'libinput Left Handed Enabled' 0
    fi

    exit 0
fi
