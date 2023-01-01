#!/usr/bin/env bash

wm=$1

if [[ $wm != "openbox" ]] && [[ $wm != "i3" ]]; then
    echo "No config name"
    exit 1
fi

# Terminate already running bar instances
killall -q polybar

# Launch bars
echo "---" | tee -a /tmp/polybar.log
polybar -c ~/.config/polybar/$wm.conf polybar >>/tmp/polybar.log 2>&1 &

echo "Bars launched..."

