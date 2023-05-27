# NafmanOs - Arch Linux Installer

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
* `./packages`  lines : 627 - 628

#### Boot from [archlinux.iso](https://archlinux.org/download/), then:
* we are waiting for a few minutes until the repositories update (`cat /etc/pacman.d/mirrorlist` - reflector.service update)
* `pacman -Sy archlinux-keyring`, if error `pacman-key --populate`
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
#### for SSD users
* enable [Periodic TRIM](https://wiki.archlinux.org/title/Solid_state_drive#Periodic_TRIM)
    * `sudo systemctl enable fstrim.timer`
* if **NVME** freeze [Troubleshooting](https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting)
    * in `/etc/default/grub` add to `GRUB_CMDLINE_LINUX_DEFAULT` following `nvme_core.default_ps_max_latency_us=5500`
    * to see changes after reboot: `cat /sys/module/nvme_core/parameters/default_ps_max_latency_us`
***

#### Trackball configs
* copy `files/xorg.conf.d/<file>.conf` -> `/etc/X11/xorg.conf.d`
***

#### `hooks/` - for devolopers

* change **Ru localization** lines from `packages` in `README.md`
    * for automate - copy this hooks to `.git/hooks/`
    * for manual - run in `hooks/`
* update icons cache for new icons badge: `sudo gtk-update-icon-cache -f /usr/share/icons/hicolor/`

