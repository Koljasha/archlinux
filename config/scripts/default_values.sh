#!/usr/bin/bash

#
# change config values for eth, wifi
#

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

# ethernet interface
ethernet=`nmcli device | grep 'ethernet' | awk '{ print $1 }'`
line=`grep -n 'module/eth' ~/.config/polybar/openbox.conf | cut -d':' -f1`
line=$((line+2))
sed -i -e "${line}s/interface = .*/interface = ${ethernet}/" ~/.config/polybar/openbox.conf

# wifi interface
wifi=`nmcli device | grep 'wifi' | awk '{ print $1 }'`
line=`grep -n 'module/wlan' ~/.config/polybar/openbox.conf | cut -d':' -f1`
line=$((line+2))
sed -i -e "${line}s/interface = .*/interface = ${wifi}/" ~/.config/polybar/openbox.conf

