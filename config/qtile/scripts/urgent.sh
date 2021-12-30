#!/usr/bin/env bash

#
# do last window urgent
#

wmid=$(wmctrl -l | tail -n1 | cut -d" " -f1)
wmctrl -i -r "$wmid" -b add,demands_attention

