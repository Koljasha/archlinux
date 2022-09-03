#!/usr/bin/env bash

#
# show and change keyboard layout
#

if [[ $1 != "change" ]]; then
    echo $(xkb-switch)
else
    xkb-switch --next
fi

