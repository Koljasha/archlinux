#!/usr/bin/env bash

#
# xbindkeys for different devices
#

deft_pro=`xinput list | grep 'pointer' | grep -i 'Deft Pro'`
huge=`xinput list | grep 'pointer' | grep -i 'Huge'`
orbit_fusion=`xinput list | grep 'pointer' | grep -i 'Orbit Fusion'`

killall xbindkeys 2>/dev/null

if [[ $deft_pro != '' ]]; then
    xbindkeys -f ~/.config/xbindkeys/xbindkeysrc_deft_pro
elif [[ $huge != '' ]]; then
    xbindkeys -f ~/.config/xbindkeys/xbindkeysrc_huge
elif [[ $orbit_fusion != '' ]]; then
    xbindkeys -f ~/.config/xbindkeys/xbindkeysrc_orbit_fusion
else
    xbindkeys -f ~/.config/xbindkeys/xbindkeysrc
fi

