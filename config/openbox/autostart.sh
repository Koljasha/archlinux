#!/usr/bin/env bash

# Numlock on
numlockx on &

# Disable Xorg screensaver
xset -dpms &
xset s off &

# Disable beeper
xset -b &

# PolicyKit Authentication Agent - Gnome
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Notifications
dunst &

# Bluetooth applet
blueman-applet &

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
    feh --bg-scale /usr/share/backgrounds/archlinux/simple.png &
else
    # NetworkManager applet
    nm-applet  --indicator &
fi

# Change values for brightness, eth, wifi
~/.config/scripts/default_values.sh &

# Additionally bindings
~/.config/scripts/xbindkeys.sh &

# Set mouse params | show devices: `xinput list`
# ~/.config/scripts/mouse.sh set "Logitech MX Ergo" &
# ~/.config/scripts/mouse.sh set "BT4.0+2.4G Mouse" -0.90 &

# Set screen resolution for Virtual Box
# xrandr -s 1360x768 &

