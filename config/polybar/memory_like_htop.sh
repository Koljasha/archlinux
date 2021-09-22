#!/usr/bin/env bash

function to_Gb {
    data=`echo $1 | awk '{ print $0/1024 }'`
    left=`echo $data | cut -d'.' -f1`
    right=`echo $data | cut -d'.' -f2 | awk '{ print substr($0,0,2) }'`
    echo "$left.$right Gb"
}


full_memory=`free -m | sed -n 2p | awk '{print $2}'`
full_memory=`to_Gb $full_memory`

busy_memory=`free -m | sed -n 2p | awk '{print $3+$5}'`
if (( $busy_memory > 1024 )); then
    busy_memory=`to_Gb $busy_memory`
else
    busy_memory=`echo "$busy_memory Mb"`
fi

echo "U:$busy_memory | T:$full_memory"
