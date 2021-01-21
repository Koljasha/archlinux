#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# polybar - change display output
disp=`xrandr | grep "connected primary" | cut -d" " -f1`
sed -i "s/--output.*--brightness/--output $disp --brightness/" ~/.config/polybar/change_brightness.sh

# ethernet interface
ethernet=`nmcli device | grep 'ethernet' | awk '{ print $1 }'`
line=`grep -n 'module/eth' ~/.config/polybar/i3.conf | cut -d':' -f1`
line=$((line+2))
sed -i -e "${line}s/interface = .*/interface = ${ethernet}/" ~/.config/polybar/i3.conf

# wifi interface
wifi=`nmcli device | grep 'wifi' | awk '{ print $1 }'`
line=`grep -n 'module/wlan' ~/.config/polybar/i3.conf | cut -d':' -f1`
line=$((line+2))
sed -i -e "${line}s/interface = .*/interface = ${wifi}/" ~/.config/polybar/i3.conf

# Launch bars
echo "---" | tee -a /tmp/polybar.log
polybar -c ~/.config/polybar/i3.conf polybar >>/tmp/polybar.log 2>&1 &

echo "Bars launched..."

