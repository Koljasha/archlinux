# defined function to show charge mouse and keyboard info
#
function charge --description 'show charge mouse and keyboard info'
    echo -e "############### \n"
    for devices in (upower -e)
        echo -e "$devices \n"
        upower -i $devices
        echo -e "############### \n"
    end
end

