#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bars
echo "---" | tee -a /tmp/polybar.log
polybar -c ~/.config/polybar/openbox.conf polybar >>/tmp/polybar.log 2>&1 &

echo "Bars launched..."
