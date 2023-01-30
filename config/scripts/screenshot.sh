#!/usr/bin/env bash

#
# make screenshot with terminal command
#
# yay -S maim grim slurp swappy wl-clipboard
#

if (( $# != 1 )); then
    echo "Error! No mode. Use: ./screenshot.sh full|region|edit"
    exit 2
fi

mode=$1
screenshot="$(xdg-user-dir)/Downloads/screenshot-$(date +'%Y_%m_%d-%H_%M_%S').png"

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    case $mode in
        full)
            grim $screenshot
            rofi -e "Screenshot created: $screenshot"
            ;;
        region)
            grim -g "$(slurp)" $screenshot
            rofi -e "Screenshot created: $screenshot"
            ;;
        edit)
            grim -g "$(slurp)" $screenshot
            if (( $? != 0 )); then
                exit 0
            fi
            swappy -f $screenshot &
            ;;
        *)
            echo "Error! Invalid mode. Use ./screenshot/sh full|region|edit "
            ;;
    esac
else
    case $mode in
        full)
            maim $screenshot
            rofi -e "Screenshot created: $screenshot"
            ;;
        region)
            maim --select $screenshot
            rofi -e "Screenshot created: $screenshot"
            ;;
        edit)
            maim --select $screenshot
            if (( $? != 0 )); then
                exit 0
            fi
            swappy -f $screenshot &

            # move swappy to center
            # Bug, maybe because Swappy is Wayland app
            sleep 0.5

            display_dimensions=`xdpyinfo | grep -oP 'dimensions:\s+\K\S+'`
            display_width=`echo $display_dimensions | cut -d'x' -f1`
            display_heigth=`echo $display_dimensions | cut -d'x' -f2`

            app_id=`xdotool search --onlyvisible --name swappy | tail -1`
            app_dimensions_position=`xdotool getwindowgeometry --shell $app_id`
            app_width=`echo "$app_dimensions_position" | grep 'WIDTH=' | cut -d'=' -f2`
            app_heigth=`echo "$app_dimensions_position" | grep 'HEIGHT=' | cut -d'=' -f2`

            position_x=`echo $display_width $app_width | awk '{ print ($1-$2)/2 }' | cut -d. -f1`
            position_y=`echo $display_heigth $app_heigth | awk '{ print ($1-$2)/2 }' | cut -d. -f1`

            xdotool windowmove $app_id $position_x $position_y
            ;;
        *)
            echo "Error! Invalid mode. Use ./screenshot.sh full|region|edit "
            ;;
    esac
fi

