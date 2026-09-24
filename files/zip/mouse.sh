#!/usr/bin/env bash

#
# задаём параметры мыши
# https://man.archlinux.org/man/libinput.4.en
#

if (( $# == 1 )) && [[ $1 == "list" ]]; then
    xinput list
elif (( ($# == 2) || ($# == 3) )) && [[ ($1 == "get") || ($1 == "set") ]]; then
    mouse_name=$2
    id=`xinput list | grep "$mouse_name" | head -n1 | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`

    if [[ $id == "" ]]; then
        echo "No '$mouse_name' device"
        exit 0
    fi

    # получаем параметры мыши

    if [[ $1 == "get" ]]; then
        xinput list-props $id
        echo "Buttons Map:"
        xinput get-button-map $id
        exit 0
    fi

    # задаём параметры мыши

    # нажатие|клик (с фиксацией) средней кнопкой и движение мыши для прокрутки
    xinput set-prop $id "libinput Button Scrolling Button" 2
    xinput set-prop $id "libinput Scroll Method Enabled" 0, 0, 1
    xinput set-prop $id "libinput Button Scrolling Button Lock Enabled" 1

    # делаем фиксацию левой кнопки на кнопке Forward
    # xinput set-prop $id "libinput Drag Lock Buttons" 9 1

    if [[ $3 != "" ]]; then
        # задаём скорость мыши: -1.0 <> 1.0
        xinput set-prop $id "libinput Accel Speed" $3
    fi

    echo "Parameters for '$mouse_name' are set"
    exit 0

    # эмулируем среднюю кнопку нажатием левой и правой кнопок
    # настраиваем команду Back для этой комбинации
    # xinput set-prop $id "libinput Middle Emulation Enabled" 1
    # xinput set-button-map $id 1 8 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
else
    echo "Error: No args"
    echo "$ ./mouse.sh list or ./mouse.sh get|set <name>"
    exit 2
fi

