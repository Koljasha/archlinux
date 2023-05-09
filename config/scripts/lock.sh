#!/usr/bin/env bash

#
# lock script
#

terminator --geometry=1920x1080 --fullscreen --execute cmatrix -Lrb &
sleep 1
i3lock -c 000000 -n
killall cmatrix

