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
* `./packages`  lines : 684 - 685

#### Boot from [archlinux.iso](https://archlinux.org/download/), then:
* we are waiting for a few minutes until the repositories update (`cat /etc/pacman.d/mirrorlist` - reflector.service update)
* `pacman -Sy pacman` if error try:
    * `pacman -Sy archlinux-keyring` or `pacman-key --populate`
* `pacman -Sy git`
* `git clone https://github.com/koljasha/archlinux`
* `cd archlinux && ./installer`

***
#### [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide) - it is advisable to use [Archinstall](https://wiki.archlinux.org/title/Archinstall) with minimal installation
* `./installer` - install system like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
    * `/dev/sda` - auto mount
    * other      - manual mount
* `./chroot` *(run from ./installer)* - install system in arch-root mode like [Arch Linux Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide#Chroot)
#### NafmanOs - need [Git](https://wiki.archlinux.org/title/Git) installed
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
* `./swapfile` - create swapfile in work system

***
#### for SSD users
* enabled by default [Periodic TRIM](https://wiki.archlinux.org/title/Solid_state_drive#Periodic_TRIM)
    * `sudo systemctl status fstrim.timer`
* if **NVME** freeze [Troubleshooting](https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting)
    * in `/etc/default/grub` add to `GRUB_CMDLINE_LINUX_DEFAULT` following `nvme_core.default_ps_max_latency_us=5500`
    * to see changes after reboot: `cat /sys/module/nvme_core/parameters/default_ps_max_latency_us`
***

#### Trackball mouse configuration options
1. **Xorg**:
    * `files/xorg.conf.d/70-trackball.conf` -> `/etc/X11/xorg.conf.d/`
    * list: `xinput list`
    * info: `xinput list-props <id>`
2. **Xorg**, **Wayland**:
    * `files/hwdb.d/70-mouse-remap.hwdb` -> `/etc/udev/hwdb.d/`
    * list: `sudo libinput list-devices`
    * info: `sudo udevadm info /dev/input/event<id>`
    * click buttons: `sudo evtest`
    * enable: `sudo systemd-hwdb update` and `sudo udevadm trigger`
3. **Xorg**, **Wayland**: [Input Remapper](https://github.com/sezanzeb/input-remapper/)
4. **Xorg**, **Wayland**: [libinput-config](https://gitlab.com/warningnonpotablewater/libinput-config/)
5. *other way*: [Arch Wiki](https://wiki.archlinux.org/title/Input_remap_utilities)
***

#### `hooks/` - for devolopers

* change **Ru localization** lines from `packages` in `README.md`
    * for automate - copy this hooks to `.git/hooks/`
    * for manual - run in `hooks/`
* update icons cache for new icons badge: `sudo gtk-update-icon-cache -f /usr/share/icons/hicolor/`

