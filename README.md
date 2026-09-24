# NafmanOs — установщик Arch Linux

## Только для тех, кто понимает Arch Linux → [Руководство по установке Arch Linux](https://wiki.archlinux.org/index.php/Installation_guide)

***
#### Запись ISO на USB-флешку ([Wiki](https://wiki.archlinux.org/title/USB_flash_installation_medium#Using_basic_command_line_utilities))
```
# sudo dd bs=4M if=path/to/archlinux-x86_64.iso of=/dev/sd_X_ conv=fsync oflag=direct status=progress
```

***
#### Русская локализация включена по умолчанию; для изменения:
* `./installer` строки : 11 - 12
* `./chroot`    строки : 3 - 14
* `./packages`  строки : 726 - 727

#### Загрузитесь с [archlinux.iso](https://archlinux.org/download/), затем:
* ждём несколько минут, пока обновятся репозитории (`cat /etc/pacman.d/mirrorlist` — обновление reflector.service)
* `pacman -Sy pacman`; если ошибка, попробуйте:
    * `pacman -Scc`
    * `pacman-key --init`
    * `pacman-key --populate`
    * `pacman -Sy archlinux-keyring`
* `pacman -Sy git`
* `git clone https://github.com/koljasha/archlinux`
* `cd archlinux && ./installer`

***
#### [Руководство по установке Arch Linux](https://wiki.archlinux.org/index.php/Installation_guide)
##### рекомендуется использовать [Archinstall](https://wiki.archlinux.org/title/Archinstall) с установкой *minimal*
    * включить поддержку русского: `setfont UniCyrExt_8x16`
    * `archinstall`
##### старый вариант
    * `./installer` — установка системы как в [Руководстве по установке Arch Linux](https://wiki.archlinux.org/index.php/Installation_guide)
        * `/dev/vda` — авто-монтирование (vda — диск по умолчанию в Gnome Boxes)
        * другой      — ручное монтирование
    * `./chroot` *(запускается из ./installer)* — установка системы в режиме arch-root, как в [Руководстве](https://wiki.archlinux.org/index.php/Installation_guide#Chroot)
#### NafmanOs требует установленного [Git](https://wiki.archlinux.org/title/Git)
* `./packages` — установка рабочих столов, пакетов и их настройка
    * Openbox, i3wm, Qtile → мои настройки
    * остальные → настройки по умолчанию
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
* `./swapfile` — создать swap-файл в рабочей системе
* `./links` — создать систему симлинков (для меня: система на диске Koljasha)

***
#### для пользователей SSD
* по умолчанию включён [Periodic TRIM](https://wiki.archlinux.org/title/Solid_state_drive#Periodic_TRIM)
    * `systemctl status fstrim.timer`
* если **NVME** зависает — [Troubleshooting](https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting)
    * в `/etc/default/grub` добавить в `GRUB_CMDLINE_LINUX_DEFAULT`: `nvme_core.default_ps_max_latency_us=5500`
    * посмотреть изменения после перезагрузки: `cat /sys/module/nvme_core/parameters/default_ps_max_latency_us`
***

#### Настройка трекбола
1. **Xorg**:
    * `files/xorg.conf.d/70-trackball.conf` → `/etc/X11/xorg.conf.d/`
    * список: `xinput list`
    * информация: `xinput list-props <id>`
2. **Xorg**, **Wayland**: [evsieve](https://github.com/KarsMulder/evsieve)
3. **Xorg**, **Wayland**: [Input Remapper](https://github.com/sezanzeb/input-remapper/)
4. **Xorg**, **Wayland** *(сложный способ)*:
    * `files/hwdb.d/70-mouse-remap.hwdb` → `/etc/udev/hwdb.d/`
    * список: `sudo libinput list-devices`
    * информация: `sudo udevadm info /dev/input/event<id>`
    * нажатия кнопок: `sudo evtest`
    * включить: `sudo systemd-hwdb update` и `sudo udevadm trigger`
5. *другой способ*: [Arch Wiki](https://wiki.archlinux.org/title/Input_remap_utilities)
***

#### Нормальные зеркала в России (глобальные медленные — оператор режет скорость)
`sudo vim /etc/pacman.d/mirrorlist`
```
Server = https://mirror.yandex.ru/archlinux/$repo/os/$arch
Server = https://mirror.truenetwork.ru/archlinux/$repo/os/$arch
Server = https://mirror.nw-sys.ru/archlinux/$repo/os/$arch
Server = https://mirror.surf/archlinux/$repo/os/$arch

Server = https://geo.mirror.pkgbuild.com/$repo/os/$arch
```
***

#### `hooks/` — для разработчиков

* изменение строк **русской локализации** из `packages` в `README.md`
    * для автоматизации — скопируйте этот хук в `.git/hooks/`
    * для ручного запуска — запустите его в каталоге `hooks/`
* обновить кэш иконок для нового значка: `sudo gtk-update-icon-cache -f /usr/share/icons/hicolor/`
***
***
