#!/usr/bin/env bash

# menu for show password from pass

name=`find ~/.password-store/ -iname "*.gpg" | awk -F "/" '{print $NF}' | awk '{print substr($0, 0, length($0)-4)}' | sort | rofi -dmenu -i -p PassName`
if [[ "$name" == "" ]]; then
    exit 0
fi
file=`find ~/.password-store/ -name "*$name.gpg"`
file_pass=`echo $file | cut -d'/' -f5- | awk '{print substr($0, 0, length($0)-4)}'`

killall gpg-agent
passphrase=`echo | rofi -dmenu -password -l 0 -p Passphrase`
text=`gpg --passphrase $passphrase --batch --pinentry-mode loopback --decrypt "$file" 2>/dev/null`

if [[ "$text" != "" ]]; then
    pass -c "$file_pass" 1>/dev/null
    text=`echo "$text" | sed -n '4p'`
    text=`echo -e "$text\n\nPassword copied to clipboard.\nWill clear in 45 seconds."`
    rofi -e "$text"
else
    rofi -e "!!!--- Invalid Password. Something wrong. ---!!!"
    exit 1
fi

