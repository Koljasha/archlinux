#!/usr/bin/env bash

# generate new strong password

password=`openssl rand -base64 24`
printf "$password"| xsel --input --clipboard -z
text=`echo -e "Password copy to clipboard: $password"`
rofi -e "$text"

