#!/usr/bin/env bash

# Включаем NumLock
numlockx on &

# Отключаем скринсейвер Xorg
xset -dpms &
xset s off &

# Отключаем пищалку
xset -b &

# Агент аутентификации PolicyKit — Gnome
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Уведомления
dunst &

# Апплет Bluetooth
blueman-applet &

if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    # Прозрачность
    picom &

    # Апплет NetworkManager
    nm-applet &

    # Polybar
    ~/.config/polybar/polybar.sh i3 &

    # Фоновое изображение
    feh --bg-scale /usr/share/backgrounds/archlinux/simple.png &

    # Меняем цветовую температуру
    /usr/bin/redshift -P -O 4000

    # Перезапускаем clipmenud (обход бага)
    systemctl --user restart clipmenud.service

    # Перезапускаем clip-mirror (обход бага)
    systemctl --user restart clip-mirror.service
else
    # Меняем цветовую температуру
    /usr/bin/gammastep -O 4000 &

    # Апплет NetworkManager
    nm-applet --indicator &
fi

# Дополнительные привязки
~/.config/scripts/xbindkeys.sh &

# Устанавливаем разрешение экрана для VirtualBox
# xrandr -s 1360x768 &

