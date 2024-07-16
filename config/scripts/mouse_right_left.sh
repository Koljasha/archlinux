#!/usr/bin/env bash

# change mouse left|right hand

id=`xinput list | grep pointer | grep -Ev 'Virtual|SINO' | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`
state=`xinput list-props $id | grep 'Left Handed Enabled' | head -1 | cut -d: -f2 | tr -d "[:space:]"`

if [[ $state == '0' ]]; then
    xinput set-prop $id 'libinput Left Handed Enabled' 1
else
    xinput set-prop $id 'libinput Left Handed Enabled' 0
fi

