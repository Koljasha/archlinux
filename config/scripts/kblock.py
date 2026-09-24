#!/usr/bin/env python3
"""
kblock.py — блокировка клавиатуры в X11 с разблокировкой той же комбинацией.

НАЗНАЧЕНИЕ
    По нажатию горячей комбинации (по умолчанию Win+Pause/Break, т.е. клавиша
    "Pb" в ряду Ps/Sl/Pb) скрипт перехватывает клавиатуру целиком: все нажатия
    "проглатываются" и никуда не доходят. Повторное нажатие той же комбинации
    снимает блокировку и завершает скрипт. Мышь при этом продолжает работать.

    Готового аналога "заблокировать/разблокировать одной комбинацией без пароля"
    в Linux нет:
      * xinput disable <id> — отключает устройство для X, поэтому та же
        клавиатура уже не сможет прислать комбинацию на разблокировку
        (годится только при двух устройствах — например, мыши);
      * xtrlock / xsecurelock / xlock — тоже грабят клавиатуру, но
        разблокировка выполняется ПАРОЛЕМ, а не комбинацией;
      * keyd — системный ремаппер, умеет command(...), но не умеет
        "поглотить всю клавиатуру по тогглу".
    Поэтому здесь используется активный захват клавиатуры XGrabKeyboard:
    все события приходят только этому процессу, а он их игнорирует, пока не
    увидит нужную комбинацию. Пассивный граб оконного менеджера (Qtile) на ту
    же клавишу перекрывается активным захватом, поэтому один и тот же хоткей
    работает и на блокировку, и на разблокировку.

ЗАВИСИМОСТИ И УСТАНОВКА
    1) Требуется библиотека python-xlib (пакет есть в репозитории extra):

           sudo pacman -S python-xlib

    2) Разместите этот файл, например, в ~/.local/bin:

           install -Dm755 kblock.py ~/.local/bin/kblock.py

    3) Привяжите запуск к хоткею в конфиге Qtile
       (~/.config/qtile/config.py), где mod = "mod4" (клавиша Win/Super):

           from libqtile.config import Key
           Key([mod], "Pause", lazy.spawn("kblock.py"),
               desc="Блокировка/разблокировка клавиатуры"),

       ВНИМАНИЕ: keysym клавиши "Pb" (Pause/Break) в Qtile называется "Pause".
       Убедитесь, что эта комбинация не занята другой привязкой.

СМЕНА КОМБИНАЦИИ
    Комбинация = модификатор Win (mod4) + клавиша KBLOCK_KEY.
    Имя клавиши задаётся keysym-именем X11 через переменную окружения
    KBLOCK_KEY (по умолчанию "Pause"):
        KBLOCK_KEY=p      # для латинской "p"
        KBLOCK_KEY=Pause  # клавиша Pb (Pause/Break), по умолчанию
        KBLOCK_KEY=F12
    Список имён можно смотреть командой `xev` (нажмите клавишу и смотрите
    поле keysym) или в /usr/include/X11/keysymdef.h.
    Если меняете клавишу, не забудьте поменять и её имя в биндинге Qtile,
    например Key([mod], "p", lazy.spawn("kblock.py")).

КАК ЭТО РАБОТАЕТ
    * grab_keyboard(...) берёт активный захват клавиатуры (XGrabKeyboard).
    * Сначала скрипт ждёт, пока вы отпустите все клавиши (query_keymap),
      чтобы авто-повтор удерживаемой комбинации не снял блокировку сразу.
    * Затем в цикле читает события клавиатуры и игнорирует их, пока не
      увидит KeyPress с активным mod4 и нужным keycode.
    * После этого ungrab_keyboard(...) отпускает клавиатуру, и скрипт
      завершается. Следующее нажатие снова уйдёт в Qtile и запустит блокировку.

ВОССТАНОВЛЕНИЕ, ЕСЛИ ЧТО-ТО ПОШЛО НЕ ТАК
    * Процесс можно убить из другого терминала или по SSH:
          pkill kblock.py
      При завершении процесса X-сервер автоматически снимает захват.
    * Пока блокировка активна, комбинации Ctrl+Alt+F* тоже уходят
      захватчику, поэтому держите под рукой второй канал доступа (SSH).
"""

import os
import select
import sys
import time

from Xlib import XK, X
from Xlib import display as xdisplay

KEY_NAME = os.environ.get("KBLOCK_KEY", "Pause")  # keysym: Pause, p, F12...
MOD_MASK = X.Mod4Mask  # клавиша Win / Super


def main():
    display = xdisplay.Display()
    root = display.screen().root

    keycode = display.keysym_to_keycode(XK.string_to_keysym(KEY_NAME))
    if not keycode:
        sys.exit(f"kblock.py: неизвестная клавиша {KEY_NAME!r}")

    for _ in range(50):
        status = root.grab_keyboard(
            False,  # owner_events
            X.GrabModeAsync,  # pointer_mode
            X.GrabModeAsync,  # keyboard_mode
            X.CurrentTime,
        )
        if status == X.GrabSuccess:
            break
        time.sleep(0.1)
    else:
        sys.exit("kblock.py: не удалось захватить клавиатуру (занят другим грабом?)")
    display.flush()

    armed = False
    while not armed:
        while display.pending_events():
            display.next_event()
        if not any(display.query_keymap()):
            armed = True
            break
        select.select([display], [], [], 0.05)

    while True:
        event = display.next_event()
        if (
            event.type == X.KeyPress
            and event.detail == keycode
            and (event.state & MOD_MASK)
        ):
            break

    display.ungrab_keyboard(X.CurrentTime)
    display.flush()
    display.close()


if __name__ == "__main__":
    main()
