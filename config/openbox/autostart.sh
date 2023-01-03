#!/usr/bin/env bash

# Numlock on
numlockx on &

# Disable Xorg screensaver
xset -dpms &
xset s off &

# PolicyKit Authentication Agent - Gnome
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Notifications
dunst &

# Change values for brightness, eth, wifi
~/.config/scripts/default_values.sh &

if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    # Transparency
    picom &

    # NetworkManager applet
    nm-applet &

    # Polybar
    ~/.config/polybar/polybar.sh openbox &

    # Plank
    plank &

    # Backgroung image
    feh --randomize --bg-scale /usr/share/backgrounds/archlinux/ &
else
    # NetworkManager applet
    nm-applet  --indicator &
fi

# Set mouse speed
# ~/.config/scripts/mouse.sh M310 0.7 &
# ~/.config/scripts/mouse.sh MOSART 0.5 &

# set screen resolution for Virtual Box
# xrandr -s 1360x768 &

