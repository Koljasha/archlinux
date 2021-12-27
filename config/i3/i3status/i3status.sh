#!/usr/bin/env bash

# script i3status extended by Koljasha

function func_language {
    if [[ $(xset -q | awk '{print $4}' | sed -n 8p) = "off"  ]]
    then echo ' En'
    else echo ' Ru'
    fi
}

i3status -c ~/.config/i3/i3status/i3status.conf |
(
    read line && echo "$line" &&
    read line && echo "$line" &&
    read line && echo "$line" &&
    while true

    do
        memory=`free -h | awk '{print " U:"$3"/T:"$2}' | sed -n 2p`
        language=`func_language`

        read line

        echo ",[
            { \"full_text\":\"$language\",\"color\":\"#00ff00\" },
            { \"full_text\":\"$memory\",\"color\":\"#99d3ff\" },
            ${line#,\[}
            " || exit 1
    done
)

exit 0

###     Для понимания после do:
###     аналогично выше + дублируем memory после i3status

    do
        memory=`free -h | awk '{print " U:"$3"/T:"$2}' | sed -n 2p`
        language=`~/.config/i3/language.sh`

        read line
        status=`echo "$line" | cut -c 3- | rev | cut -c 2- | rev`

        echo ",[
            { \"full_text\":\"$language\",\"color\":\"#00ff00\" },
            { \"full_text\":\"$memory\",\"color\":\"#00ffff\" },
            $status,
            { \"full_text\":\"$memory\",\"color\":\"#00ffff\" }
            ]" || exit 1
    done
