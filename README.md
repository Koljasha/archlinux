# Arch Linux Installer (Arch repo and Aur)

## Only for Arch linux understanding users -> [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
### auto install for VirtualBox and laptops with settings by Koljasha :-)

***
#### Ru localization is default; for change:
* `./installer` lines : 11 - 12
* `./chroot`    lines : 3 - 14
* `./packages`  lines : 386 - 387

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
* `./packages` - install window managers (Openbox, i3wm | Xfce | LXDE), packages and settings it
    * for Openbox, i3wm:
        * these are the minimal apps that I use without embellishments and frills
        * key bindings and settings are mostly standard with minor changes and scripts
        * installing (building) packages from AUR takes some time
        * in `polybar` set brightness not work in VirtualBox
    * for Xfce:
        * default settings
    * for Lxde:
        * default settings
    * for Enlightenment:
        * default settings
    * for Gnome, Gnome Flashback:
        * default settings

***
#### `hooks/` - for devolopers

* change **Ru localization** lines from `packages` in `README.md`
    * for automate - copy this hooks to `.git/hooks/`
    * for manual - run in `hooks/`

