/usr/bin/env bash

status=`wmctrl -m | grep "showing the desktop" | awk -F ": " '{ print $2 }'`
if [[ $status == "OFF" ]]; then
    wmctrl -k on
else
    wmctrl -k off
fi
