#!/usr/bin/env bash

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

# Brightness:
xrandr --output $(xrandr | grep "connected primary" | cut -d" " -f1) --brightness 0.8 &
