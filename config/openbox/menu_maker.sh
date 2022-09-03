#!/usr/bin/env bash

# mmaker
mmaker -f -t GNOME-terminal OpenBox3

# start file
sed -i '3a\ \t\t<item label="Terminator"> <action name="Execute">' ~/.config/openbox/menu.xml
sed -i '4a\ \t\t\t<execute>terminator -m</execute>' ~/.config/openbox/menu.xml
sed -i '5a\ \t\t</action> </item>' ~/.config/openbox/menu.xml

sed -i '6a\ \t\t<item label="FireFox"> <action name="Execute">' ~/.config/openbox/menu.xml
sed -i '7a\ \t\t\t<execute>firefox</execute>' ~/.config/openbox/menu.xml
sed -i '8a\ \t\t</action> </item>' ~/.config/openbox/menu.xml

sed -i '9a\ \t\t<item label="PCManFM"> <action name="Execute">' ~/.config/openbox/menu.xml
sed -i '10a\ \t\t\t<execute>pcmanfm</execute>' ~/.config/openbox/menu.xml
sed -i '11a\ \t\t</action> </item>' ~/.config/openbox/menu.xml

sed -i '12a\ \t\t<separator />' ~/.config/openbox/menu.xml

# end file
sed -i '/name="Reconfigure"/ a\ \t\t\t<item label="Restart"> <action name="Restart"/> </item>' ~/.config/openbox/menu.xml

sed -i '/name="Exit"/ a\ \t\t\t</action> </item>' ~/.config/openbox/menu.xml
sed -i '/name="Exit"/ a\ \t\t\t\t<execute>systemctl -i poweroff</execute>' ~/.config/openbox/menu.xml
sed -i '/name="Exit"/ a\ \t\t\t<item label="Power Off"> <action name="Execute">' ~/.config/openbox/menu.xml

sed -i '/name="Exit"/ a\ \t\t\t</action> </item>' ~/.config/openbox/menu.xml
sed -i '/name="Exit"/ a\ \t\t\t\t<execute>systemctl -i reboot</execute>' ~/.config/openbox/menu.xml
sed -i '/name="Exit"/ a\ \t\t\t<item label="Reboot"> <action name="Execute">' ~/.config/openbox/menu.xml

