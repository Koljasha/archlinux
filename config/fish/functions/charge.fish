# defined function to show charge mouse and keyboard info
#
function charge --description 'show charge mouse and keyboard info'
    echo Charge Mouse: (upower -i (upower -e | grep mouse) | grep percentage | awk '{ print $2 }')
    echo Charge Keyboard: (upower -i (upower -e | grep keyboard) | grep percentage | awk '{ print $2 }')
end

