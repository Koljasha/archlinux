#!/usr/bin/env bash

#
# xbindkeys for different devices
#

deft_pro=`xinput list | grep 'pointer' | grep -i 'Deft Pro'`
huge=`xinput list | grep 'pointer' | grep -i 'Huge'`

killall xbindkeys 2>/dev/null

if [[ $deft_pro != '' ]]; then
    xbindkeys -f ~/.config/xbindkeys/xbindkeysrc_deft_pro
else
    xbindkeys -f ~/.config/xbindkeys/xbindkeysrc_all
fi

