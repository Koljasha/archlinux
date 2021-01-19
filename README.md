# Arch Linux Installer (Arch repo and Aur)

## Only for Arch linux understanding users -> [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
### auto install for VirtualBox (/dev/sda) and laptops with settings by Koljasha :-)

***
#### default **Ru localization** for change:
* `./installer` string : 11 - 12
* `./chroot`    string : 3 - 14

Start from archlinux.iso then:
* `pacman -Sy git`
* `git clone https://github.com/koljasha/archlinux_installer`
* `cd archlinux_installer && ./installer`

***
##### [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)

* `./installer` - install system like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
* `./chroot` - install system in arch-root mode like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide#Chroot)
* `./packages` - install desktop environments (Openbox, i3wm), packages and settings it

***
##### after install run:
* `lxappearance` - reselect theme (for qt apps theme)
* `condaupdate` - update python conda environments
