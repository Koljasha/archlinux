# Arch Linux Installer (Arch repo and Aur)

## Only for Arch linux understanding users -> [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
### auto install for VirtualBox and laptops with settings by Koljasha :-)

***
#### Ru localization is default; for change:
* `./installer` lines : 11 - 12
* `./chroot`    lines : 3 - 14
* `./packages`  lines : 318 - 319

#### Boot from [archlinux.iso](https://archlinux.org/download/), then:
* `pacman -Sy git`
* `git clone https://github.com/koljasha/archlinux_installer`
* `cd archlinux_installer && ./installer`

***
#### [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)

* `./installer` - install system like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
    * `/dev/sda` - auto mount
    * other      - manual mount
* `./chroot` *(run from ./installer)* - install system in arch-root mode like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide#Chroot)
* `./packages` - install window managers (Openbox, i3wm), packages and settings it
    * these are the minimal apps that I use without embellishments and frills
    * key bindings and settings are mostly standard with minor changes and scripts
    * installing (building) packages from AUR takes some time
    * after install run `lxappearance`: reselect theme and confirm (needed to apply the theme for QT apps, like `vlc`)
    * in `polybar` set brightness not work in VirtualBox

***
##### `hooks/` - for devolopers

* change *Ru localization* lines from `packages` in `README.md`

