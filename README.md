# Arch Linux Installer

## Only for Arch linux understanding users -> [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)

***
#### Write Iso to Usb [Wiki](https://wiki.archlinux.org/title/USB_flash_installation_medium#Using_basic_command_line_utilities)
```
# sudo dd bs=4M if=path/to/archlinux-x86_64.iso of=/dev/sd_X_ conv=fsync oflag=direct status=progress
```

***
#### Ru localization is default; for change:
* `./installer` lines : 11 - 12
* `./chroot`    lines : 3 - 14
* `./packages`  lines : 617 - 618

#### Boot from [archlinux.iso](https://archlinux.org/download/), then:
* `pacman -Sy git`
* `git clone https://github.com/koljasha/archlinux`
* `cd archlinux && ./installer`

***
#### [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)

* `./installer` - install system like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
    * `/dev/sda` - auto mount
    * other      - manual mount
* `./chroot` *(run from ./installer)* - install system in arch-root mode like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide#Chroot)
* `./packages` - install desktops, packages and settings it *(Openbox, i3wm, Qtile - my settings; other - default settings)*
    * **Qtile**, **i3wm**, **Openbox**
    * **Xfce**
    * **Lxde**
    * **Lxqt**
    * **Enlightenment**
    * **Mate**
    * **Cinnamon**
    * **Gnome**
    * **Budgie**
    * **Pantheon**
    * **Kde Plasma**
    * **Deepin**

***
#### `hooks/` - for devolopers

* change **Ru localization** lines from `packages` in `README.md`
    * for automate - copy this hooks to `.git/hooks/`
    * for manual - run in `hooks/`
* update icons cache for new icons badge: `sudo gtk-update-icon-cache -f /usr/share/icons/hicolor/`

