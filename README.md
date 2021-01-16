# Arch Linux Installer

## Only for Arch linux understanding users
#### auto install for VirtualBox and my laptops | *Ru localization*

* `pacman -Sy git`
* `git clone https://github.com/koljasha/archlinux_installer`
* `cd archlinux_installer && ./installer`

***
##### [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)

* `./installer` - install system like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
    * create GPT partions, foramat it, install Grub package :
        * /dev/sda1 - efi
        * /dev/sda2 - swap
        * /dev/sda3 - root
    * create MBR partions, foramat it, install Grub package :
        * /dev/sda1 - swap
        * /dev/sda2 - root
    * manual create partions and mount it, **not install Grub package**
* `./chroot (GPT|MBR|NO)` - install system in arch-root mode like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide#Chroot)
    * GPT - install Grub for EFI
    * MBR - install Grub for MBR
    * NO - not install Grub
* `./packages` - install packages for desktop environments (Openbox, i3wm) and settings for it

