/usr/bin/env bash

status=`pgrep -x smbd`
if [[ -z $status ]]; then
    sudo systemctl start smb.service
else
    sudo systemctl stop smb.service
fi

