#!/usr/bin/env bash

# session=`echo $XDG_SESSION_TYPE`

# set screen resolution for Virtual Box
# xrandr -s 1360x768 &

# Numlock on
numlockx on &

# Disable Xorg screensaver
xset -dpms &
xset s off &

# Transparency
picom &

# Backgroung image
feh --randomize --bg-scale /usr/share/backgrounds/archlinux/ &

# PolicyKit Authentication Agent - Gnome
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# NetworkManager applet
nm-applet &

# Notifications
dunst &

# Brightness
xrandr --output $(xrandr | grep "connected primary" | cut -d" " -f1) --brightness 0.7 &

# Change values for brightness, eth, wifi
~/.config/scripts/default_values.sh &

# Polybar
~/.config/polybar/polybar.sh i3 &

# Set mouse speed
# ~/.config/scripts/mouse.sh M310 0.7 &
# ~/.config/scripts/mouse.sh MOSART 0.5 &

