#!/usr/bin/env bash

#
# set mouse params
# https://man.archlinux.org/man/libinput.4.en
#

if (( $# == 1 )) && [[ $1 == "list" ]]; then
    xinput list
elif (( ($# == 2) || ($# == 3) )) && [[ ($1 == "get") || ($1 == "set") ]]; then
    mouse_name=$2
    id=`xinput list | grep "$mouse_name" | head -n1 | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`

    if [[ $id == "" ]]; then
        echo "No '$mouse_name' device"
        exit 0
    fi

    # get mouse params

    if [[ $1 == "get" ]]; then
        xinput list-props $id
        echo "Buttons Map:"
        xinput get-button-map $id
        exit 0
    fi

    # set mouse params

    # press|click (with the sticking) middle button and move the mouse to scroll
    xinput set-prop $id "libinput Button Scrolling Button" 2
    xinput set-prop $id "libinput Scroll Method Enabled" 0, 0, 1
    xinput set-prop $id "libinput Button Scrolling Button Lock Enabled" 1

    # make the sticking of button left on the Forward button
    # xinput set-prop $id "libinput Drag Lock Buttons" 9 1

    if [[ $3 != "" ]]; then
        # set mouse speed: -1.0 <> 1.0
        xinput set-prop $id "libinput Accel Speed" $3
    fi

    echo "Parameters for '$mouse_name' are set"
    exit 0

    # do emulation of button middle by pressing the left and right buttons
    # setting up the Back command for this combination
    # xinput set-prop $id "libinput Middle Emulation Enabled" 1
    # xinput set-button-map $id 1 8 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
else
    echo "Error: No args"
    echo "$ ./mouse.sh list or ./mouse.sh get|set <name>"
    exit 2
fi

