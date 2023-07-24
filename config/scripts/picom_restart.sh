#!/usr/bin/env bash

#
# restart Picom
#

killall picom 2>/dev/null
sleep 0.5
picom -b

