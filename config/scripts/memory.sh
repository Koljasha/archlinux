#!/usr/bin/env bash

#
# show memory like htop
#

function to_Gb {
    data=`echo $1 | awk '{ print $0/1024 }'`
    left=`echo $data | cut -d'.' -f1`
    right=`echo $data | cut -d'.' -f2 | awk '{ print substr($0,0,2) }'`
    echo "$left.$right Gb"
}

total_memory=`python -c 'import psutil; print(psutil.virtual_memory().total/1024/1024)'`
total_memory=`to_Gb $total_memory`

used_memory=`python -c 'import psutil;\
             memory = psutil.virtual_memory();\
             print(memory.used/1024/1024 + memory.shared/1024/1024)' | cut -d'.' -f1`

if (( $used_memory > 1024 )); then
    used_memory=`to_Gb $used_memory`
else
    used_memory=`echo "$used_memory Mb"`
fi

echo "$used_memory | $total_memory"

