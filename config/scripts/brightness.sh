#!/usr/bin/env bash

#
# показываем и задаём яркость и цветовую температуру
#


#
### температура
#


if [[ $1 == 'temperature' ]]; then

    declare -a options=(
    "2500\0icon\x1fvideo-display"
    "3000\0icon\x1fvideo-display"
    "3500\0icon\x1fvideo-display"
    "4000\0icon\x1fvideo-display"
    "4500\0icon\x1fvideo-display"
    "5000\0icon\x1fvideo-display"
    "5500\0icon\x1fvideo-display"
    "6000\0icon\x1fvideo-display"
    "6500\0icon\x1fvideo-display"
    )

    brightness=`grep 'redshift' ~/.config/qtile/autostart.sh | awk '{print $NF}'`

    brightness=`printf '%b\n' "${options[@]}" \
                | rofi -dmenu -l 3 -select $brightness -p Temperature`
                # смена на dmenu -> переместить выше rofi
                # | dmenu -b -i -p Brightness:`
    if [[ $brightness == "" ]]; then
        exit 0
    fi
    /usr/bin/redshift -P -O $brightness

    exit 0
fi


#
### яркость
#


brightness=`brightnessctl | grep Current | cut -d'(' -f2 | cut -d'%' -f1`
if (( $# == 0 )); then
    echo "$brightness%"
    exit 0
fi

###
# округляем яркость для вставки в rofi -select
#
# подстрока - ${string:position:length}
# длина - ${#string}
###
last=${brightness: -1:1}
prelast=${brightness: -2:1}
other=${brightness:0:${#brightness}-2}
case $last in
    1|2|3|4)
        brightness="${other}${prelast}0"
        ;;
    5|6|7|8|9)
        prelast=$((prelast+1))
        brightness="${other}${prelast}0"
        ;;
    *)
        ;;
esac
###

if [[ $1 != 'change' ]]; then
    echo 'Error: Invalid arguments [ change ]'
    exit 2
fi

# меняем яркость
declare -a options=(
"100\0icon\x1fvideo-display"
"90\0icon\x1fvideo-display"
"80\0icon\x1fvideo-display"
"70\0icon\x1fvideo-display"
"60\0icon\x1fvideo-display"
"50\0icon\x1fvideo-display"
"40\0icon\x1fvideo-display"
"30\0icon\x1fvideo-display"
"20\0icon\x1fvideo-display"
"10\0icon\x1fvideo-display"
)

brightness=`printf '%b\n' "${options[@]}" \
            | rofi -dmenu -l 3 -select $brightness -p Brightness`
            # смена на dmenu -> переместить выше rofi
            # | dmenu -b -i -p Brightness:`
if [[ $brightness == "" ]]; then
    exit 0
fi
brightnessctl set "$brightness%"

