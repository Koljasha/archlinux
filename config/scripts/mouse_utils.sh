#!/usr/bin/env bash

#
# утилиты для мыши
#

if [[ $1 == 'scroll_button' ]]; then

    # меняем кнопку прокрутки мыши
    # используется с Kensington Expert для изменения размера окна в Qtile и i3wm

    id=`xinput list | grep pointer | grep -Ev 'Virtual|SINO' | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`
    state=`xinput list-props $id | grep 'Button Scrolling Button' | head -1 | cut -d: -f2 | tr -d "[:space:]"`

    # состояние по умолчанию — 2

    if [[ $state == '2' ]]; then
        xinput set-prop $id 'libinput Button Scrolling Button' 3
    else
        xinput set-prop $id 'libinput Button Scrolling Button' 2
    fi

    exit 0
fi

if [[ $1 == 'left_right' ]]; then

    # меняем руку мыши: левая|правая

    id=`xinput list | grep pointer | grep -Ev 'Virtual|SINO' | sed -E "s/^.*id=([0-9]{1,2}).*/\1/"`
    state=`xinput list-props $id | grep 'Left Handed Enabled' | head -1 | cut -d: -f2 | tr -d "[:space:]"`

    if [[ $state == '0' ]]; then
        xinput set-prop $id 'libinput Left Handed Enabled' 1
    else
        xinput set-prop $id 'libinput Left Handed Enabled' 0
    fi

    exit 0
fi
