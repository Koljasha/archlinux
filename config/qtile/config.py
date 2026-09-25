# Конфигурация Qtile
# Документация: http://docs.qtile.org/en/latest/

import os
import re
import subprocess

import psutil
from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, DropDown, Group, Key, KeyChord, Match, ScratchPad, Screen
from libqtile.lazy import lazy

if qtile.core.name == "wayland":
    from libqtile.backend.wayland import InputConfig

# from libqtile.log_utils import logger  # F401: импорт не используется (оставлен для отладки)

######### Переменные и функции #########

mod = "mod4"
alt = "mod1"

colors = {
    "green": "#55aa55",
    "red": "#bd2c40",
    "yellow":"#ffb52a",
    "white": "#ffffff",
    "light_gray": "#f3f4f5",
    "gray" : "#757575",
    "dark_gray": "#222222",
    "light_blue": "#99d3ff",
    "blue": "#215578",
}

scripts = {
    "autostart": os.path.expanduser("~/.config/qtile/autostart.sh"),

    "shell": os.path.expanduser("~/.config/scripts/shell.sh"),

    "power": os.path.expanduser("~/.config/scripts/power.sh"),
    "picom_restart": os.path.expanduser("~/.config/scripts/utils.sh picom"),

    "voice_dictation": os.path.expanduser("~/.local/opt/gigaam/dictate toggle"),
    "kblock": os.path.expanduser("~/.config/scripts/kblock.py"),

    "brightness": os.path.expanduser("~/.config/scripts/brightness.sh"),
    "brightness_temperature": os.path.expanduser("~/.config/scripts/brightness.sh temperature"),
    "password": os.path.expanduser("~/.config/scripts/password.sh"),
    "password_generate": os.path.expanduser("~/.config/scripts/password.sh generate"),
    "volume": os.path.expanduser("~/.config/scripts/volume.sh"),
    "workspaces": os.path.expanduser("~/.config/scripts/workspaces.sh"),

    "keyboard": os.path.expanduser("~/.config/scripts/keyboard.sh"),
    "mouse_right_left": os.path.expanduser("~/.config/scripts/mouse_utils.sh left_right"),
    "mouse_scrolling_button": os.path.expanduser("~/.config/scripts/mouse_utils.sh scroll_button"),
    "screenshot": os.path.expanduser("~/.config/scripts/screenshot.sh"),
    "updates": os.path.expanduser("~/.config/scripts/updates.sh"),

    "singbox": os.path.expanduser("~/.config/scripts/vpn_singbox.sh"),
    # "wireguard": os.path.expanduser("~/.config/scripts/vpn_wireguard.sh"),
    # "openvpn": os.path.expanduser("~/.config/scripts/vpn_openvpn.sh"),
}

@hook.subscribe.startup_once
def autostart():
    subprocess.run([scripts["autostart"]], check=False)

@lazy.function
def increase_gaps(qtile):
    qtile.current_layout.margin += 5
    qtile.current_group.layout_all()

@lazy.function
def decrease_gaps(qtile):
    qtile.current_layout.margin = max(0, qtile.current_layout.margin - 5)
    qtile.current_group.layout_all()

@lazy.function
def move_prev_group(qtile):
    groups = qtile.groups[:-1] # без ScratchPad
    index =  groups.index(qtile.current_group)
    index = len(groups)-1 if index == 0 else index-1
    qtile.current_window.togroup(groups[index].name, switch_group=True)

@lazy.function
def move_next_group(qtile):
    groups = qtile.groups[:-1] # без ScratchPad
    index =  groups.index(qtile.current_group)
    index = 0 if index == len(groups)-1 else index+1
    qtile.current_window.togroup(groups[index].name, switch_group=True)

@lazy.function
def toggle_minimize(qtile):
    for window in qtile.current_group.windows:
        if hasattr(window, "toggle_minimize"):
            window.toggle_minimize()

if qtile.core.name == "x11":
    @hook.subscribe.client_managed
    def make_urgent(window):
        if qtile.current_window is None or qtile.current_window.wid != window.wid:
            atom = {qtile.core.conn.atoms["_NET_WM_STATE_DEMANDS_ATTENTION"]}
            prev_state = set(window.window.get_property("_NET_WM_STATE", "ATOM", unpack=int))
            new_state = prev_state | atom
            window.window.set_property("_NET_WM_STATE", list(new_state))

# Wayland: https://docs.qtile.org/en/latest/manual/wayland.html
if qtile.core.name == "wayland":
    # список устройств: qtile cmd-obj -o core -f get_inputs
    wl_input_rules = {

        # Мышь
        "1149:4128:Kensington Expert Mouse": InputConfig(
            pointer_accel=0.10,
            scroll_method='on_button_down',
            scroll_button=0x111,        # BTN_RIGHT = 273 в linux/input-event-codes.h
        ),
        # прочие (пример настройки для Elecom)
        "type:pointer": InputConfig(
            pointer_accel=-0.30,
            scroll_method='on_button_down',
            scroll_button=0x117,
        ),

        # Клавиатура
        "type:keyboard": InputConfig(
            kb_layout="us,ru",
            # переключение по Alt+Shift и лампа для получения раскладки в скрипте
            kb_options="grp:alt_shift_toggle,grp_led:scroll", 
        ),
    }

######### Горячие клавиши #########

keys = [

    ######### Основное #########

    # Закрыть активное окно
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Закрыть активное окно"),

    # Перезагрузить | Перезапустить Qtile
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Перезагрузить конфигурацию Qtile"),
    Key([mod, "control"], "r", lazy.restart(), desc="Перезапустить Qtile"),

    # Меню выхода
    Key([mod, "shift"], "p", lazy.spawn(scripts["power"]), desc="Выход | Перезагрузка | Выключение"),
    Key([mod, "control"], "p", lazy.shutdown(), desc="Завершить Qtile"),

    # Перезапуск Picom
    Key([mod], "p", lazy.spawn(scripts["picom_restart"]), desc="Перезапустить Picom"),

    # Голосовой ввод
    Key([mod], "Insert", lazy.spawn(scripts["voice_dictation"]), desc="Голосовой ввод"),
    Key([mod], "F1", lazy.spawn(scripts["voice_dictation"]), desc="Голосовой ввод"),

    # Блокировка клавиатуры
    Key([mod], "Pause", lazy.spawn(scripts["kblock"]), desc="Блокировка клавиатуры"),

    # Сменить обои
    Key([mod, "control"], "b", lazy.spawn("systemctl --user start setbg.service"), desc="Сменить обои"),

    # Убить окно
    Key([alt, "control"], "Delete", lazy.spawn("xkill"), desc="Закрыть окно"),
    # Перезагрузка системы
    Key([mod, alt, "control"], "Delete", lazy.spawn("systemctl -i reboot"), desc="Перезагрузить систему"),

    # Сменить руку мыши
    Key([mod, "control"], "m", lazy.spawn(scripts["mouse_right_left"]), desc="Сменить руку мыши"),
    # Сменить кнопку прокрутки мыши
    Key([mod, "shift"], "m", lazy.spawn(scripts["mouse_scrolling_button"]), desc="Сменить кнопку прокрутки мыши"),

    ######### Меню #########

    Key([mod], "d", lazy.spawn("dmenu_run -b -i"), desc="Запустить dmenu"),

    Key([mod], "grave", lazy.spawn("jgmenu_run"), desc="Запустить jgmenu"),

    Key([mod], "a", lazy.spawn("rofi -show drun"), desc="Запустить rofi drun"),
    Key([mod, "shift"], "a", lazy.spawn("rofi -show run"), desc="Запустить rofi run"),
    Key([mod], "Tab", lazy.spawn("rofi -show window"), desc="Запустить rofi window"),

    ######### Меню управления #########

    # Яркость
    Key([mod, "shift"], "z", lazy.spawn(f"{scripts['brightness']} change"), desc="Изменить яркость"),
    Key([mod, "control"], "z", lazy.spawn(f"{scripts['brightness_temperature']}"), desc="Изменить цветовую температуру"),

    # Буфер обмена
    # редко затупливает, тогда:
    # systemctl --user restart clipmenud.service
    Key([mod], "c", lazy.spawn("clipmenu"), desc="История буфера обмена"),

    # Пароли
    Key([mod], "s", lazy.spawn(scripts["password"]), desc="Меню паролей"),
    Key([mod, "shift"], "s", lazy.spawn(scripts["password_generate"]), desc="Меню генерации пароля"),

    # Громкость
    Key([mod], "z", lazy.spawn(f"{scripts['volume']} change"), desc="Изменить громкость"),

    # Рабочие столы
    Key([mod], "x", lazy.spawn(f"{scripts['workspaces']} change"), desc="Сменить рабочий стол"),
    Key([mod, "shift"], "x", lazy.spawn(f"{scripts['workspaces']} move"), desc="Переместить на рабочий стол"),

    ######### Система #########

    # Управление громкостью
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%"), desc="Громкость выше"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%"), desc="Громкость ниже"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle"), desc="Выключить звук"),

    # Скриншот
    Key([], "Print", lazy.spawn(f"{scripts['screenshot']} full"), desc="Сделать скриншот"),
    Key([mod], "Print", lazy.spawn(f"{scripts['screenshot']} region"), desc="Сделать скриншот"),
    Key([mod, "shift"], "Print", lazy.spawn(f"{scripts['screenshot']} edit"), desc="Сделать скриншот"),
    # Key([], "Print", lazy.spawn("gnome-screenshot --interactive"), desc="Сделать скриншот"),

    # Уведомления
    Key([mod, "shift"], "n", lazy.spawn("dunstctl close-all"), desc="Закрыть уведомления"),
    Key([mod, "control"], "n", lazy.spawn("dunstctl history-pop"), desc="История уведомлений"),

    # VPN
    Key([mod, "shift"], "v", lazy.spawn(f"{scripts['singbox']} change"), desc="Включить|Выключить VPN"),
    # Key([mod, "shift"], "v", lazy.spawn(f"{scripts['wireguard']} change"), desc="Включить|Выключить VPN"),
    # Key([mod, "shift"], "v", lazy.spawn(f"{scripts['openvpn']} change"), desc="Включить|Выключить VPN"),

    # Обновление системы
    Key([mod, "shift"], "u", lazy.spawn(scripts["updates"]), desc="Обновление системы"),

    ######### Приложения #########

    # Терминал
    Key([mod], "Return", lazy.spawn(f"{scripts['shell']} alacritty"), desc="Запустить терминал"),
    Key([mod, "shift"], "Return", lazy.spawn(f"{scripts['shell']} terminator"), desc="Запустить терминал"),

    Key([mod, "control"], "Return", lazy.spawn("alacritty --command ranger"), desc="Запустить терминал"),

    # Браузер
    Key([mod], "b", lazy.spawn("firefox"), desc="Запустить браузер"),

    # Запустить htop
    Key([mod], "t", lazy.spawn("terminator -x htop"), desc="Запустить htop"),

    # Fn-клавиши
    Key([], "XF86Explorer", lazy.spawn("pcmanfm"), desc="PcManFm"),
    Key([], "XF86HomePage", lazy.spawn("google-chrome-stable"), desc="Google Chrome"),
    Key([], "XF86Mail", lazy.spawn("obsidian"), desc="Obsidian"),
    Key([], "XF86Tools", lazy.spawn("Telegram"), desc="Telegram"),
    Key([], "XF86Calculator", lazy.spawn("gnome-calculator"), desc="Калькулятор"),
    # Key([], "XF86Search", lazy.spawn("google-chrome-stable"), desc="Google Chrome"),

    ######### Окна #########

    # Переключение между окнами
    Key([mod], "Left", lazy.layout.left(), desc="Фокус влево"),
    Key([mod], "h", lazy.layout.left(), desc="Фокус влево"),
    Key([mod], "Down", lazy.layout.down(), desc="Фокус вниз"),
    Key([mod], "j", lazy.layout.down(), desc="Фокус вниз"),
    Key([mod], "Up", lazy.layout.up(), desc="Фокус вверх"),
    Key([mod], "k", lazy.layout.up(), desc="Фокус вверх"),
    Key([mod], "Right", lazy.layout.right(), desc="Фокус вправо"),
    Key([mod], "l", lazy.layout.right(), desc="Фокус вправо"),

    # Перемещение окон между колонками или вверх/вниз в текущем стеке.
    # Перемещение за границу в раскладке Columns создаёт новую колонку.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Переместить окно влево"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Переместить окно влево"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Переместить окно вниз"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Переместить окно вниз"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Переместить окно вверх"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Переместить окно вверх"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Переместить окно вправо"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Переместить окно вправо"),

    # Изменение размера окон. Если окно у края экрана, а направление —
    # к краю, окно будет уменьшаться.
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Расширить окно влево"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Расширить окно влево"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Расширить окно вниз"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Расширить окно вниз"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Расширить окно вверх"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Расширить окно вверх"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Расширить окно вправо"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Расширить окно вправо"),
    # или
    KeyChord([mod, "shift"], "space", [
            Key([], "Left", lazy.layout.grow_left(), desc="Расширить окно влево"),
            Key([], "h", lazy.layout.grow_left(), desc="Расширить окно влево"),
            Key([], "Down", lazy.layout.grow_down(), desc="Расширить окно вниз"),
            Key([], "j", lazy.layout.grow_down(), desc="Расширить окно вниз"),
            Key([], "Up", lazy.layout.grow_up(), desc="Расширить окно вверх"),
            Key([], "k", lazy.layout.grow_up(), desc="Расширить окно вверх"),
            Key([], "Right", lazy.layout.grow_right(), desc="Расширить окно вправо"),
            Key([], "l", lazy.layout.grow_right(), desc="Расширить окно вправо"),

            Key([], "Return", lazy.ungrab_chord()), # выход из режима аккорда (Esc)
            Key([mod, "shift"], "space", lazy.ungrab_chord()), # выход из режима аккорда (Esc)
            ],
            mode=True,
            name="  " ,
        ),

    Key([mod], "space", lazy.layout.normalize(), desc="Сбросить размеры всех окон"),

    Key([alt], "Tab", lazy.layout.next(), desc="Передать фокус другому окну"),

    Key([mod], "m", toggle_minimize(), desc="Свернуть/развернуть окно"),

    ######### Раскладки #########

    Key([mod], "w", lazy.next_layout(), desc="Переключить раскладку"),
    Key([mod], "e", lazy.layout.toggle_split(), desc="Переключить split/unsplit стека"),

    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Переключить плавающий режим"),
    Key([mod, "control"], "f", lazy.window.toggle_fullscreen(), desc="Переключить полноэкранный режим"),

    KeyChord([mod, "control"], "space", [
            Key([], "Down", increase_gaps(), desc="Увеличить отступы"),
            Key([], "Right", increase_gaps(), desc="Увеличить отступы"),
            Key([], "Up", decrease_gaps(), desc="Уменьшить отступы"),
            Key([], "Left", decrease_gaps(), desc="Уменьшить отступы"),

            Key([], "Return", lazy.ungrab_chord()), # выход из режима аккорда (Esc)
            Key([mod, "control"], "space", lazy.ungrab_chord()), # выход из режима аккорда (Esc)
            ],
            mode=True,
            name="  " ,
        ),

    ######### Рабочие столы #########

    Key([alt, "control"], "Left", lazy.screen.prev_group(skip_empty=True), desc="Сменить группу"),
    Key([alt, "control"], "h", lazy.screen.prev_group(skip_empty=True), desc="Сменить группу"),
    Key([alt, "control"], "Right", lazy.screen.next_group(skip_empty=True), desc="Сменить группу"),
    Key([alt, "control"], "l", lazy.screen.next_group(skip_empty=True), desc="Сменить группу"),

    Key([alt, "control"], "Down", move_prev_group(), desc="Переместить окно в предыдущую группу"),
    Key([alt, "control"], "j", move_prev_group(), desc="Переместить окно в предыдущую группу"),
    Key([alt, "control"], "Up", move_next_group(), desc="Переместить окно в следующую группу"),
    Key([alt, "control"], "k", move_next_group(), desc="Переместить окно в следующую группу"),

    Key([mod], "backspace", lazy.group["scratchpad"].dropdown_toggle("terminal"), desc="Скретчпад"),

    ######### Мышь на клавиатуре #########

    KeyChord([mod], "Home", [
            Key([], "Left", lazy.spawn("xdotool mousemove_relative -- -50 0"), desc="Мышь влево"),
            Key(["shift"], "Left", lazy.spawn("xdotool mousemove_relative -- -10 0"), desc="Мышь влево"),
            Key(["control"], "Left", lazy.spawn("xdotool mousemove_relative -- -250 0"), desc="Мышь влево"),

            Key([], "Right", lazy.spawn("xdotool mousemove_relative -- 50 0"), desc="Мышь вправо"),
            Key(["shift"], "Right", lazy.spawn("xdotool mousemove_relative -- 10 0"), desc="Мышь вправо"),
            Key(["control"], "Right", lazy.spawn("xdotool mousemove_relative -- 250 0"), desc="Мышь вправо"),

            Key([], "Up", lazy.spawn("xdotool mousemove_relative -- 0 -50"), desc="Мышь вверх"),
            Key(["shift"], "Up", lazy.spawn("xdotool mousemove_relative -- 0 -10"), desc="Мышь вверх"),
            Key(["control"], "Up", lazy.spawn("xdotool mousemove_relative -- 0 -250"), desc="Мышь вверх"),

            Key([], "Down", lazy.spawn("xdotool mousemove_relative -- 0 50"), desc="Мышь вниз"),
            Key(["shift"], "Down", lazy.spawn("xdotool mousemove_relative -- 0 10"), desc="Мышь вниз"),
            Key(["control"], "Down", lazy.spawn("xdotool mousemove_relative -- 0 250"), desc="Мышь вниз"),

            Key([], "Return", lazy.spawn("xdotool click 1"), desc="Левый клик мыши"),
            Key([], "Page_Up", lazy.spawn("xdotool click 4"), desc="Колесо мыши вверх"),
            Key([], "Page_Down", lazy.spawn("xdotool click 5"), desc="Колесо мыши вниз"),
            Key([], "Insert", lazy.spawn("xdotool click 9"), desc="Дополнительная кнопка мыши"),
            Key([], "Delete", lazy.spawn("xdotool click 8"), desc="Дополнительная кнопка мыши"),

            Key([mod], "Home", lazy.ungrab_chord()), # выход из режима аккорда (Esc)
            ],
            mode=True,
            name="  ",
        ),

]

######### Мышь #########

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button4", lazy.window.bring_to_front())
]


######### Группы #########

groups = [
    Group("1: "),
    Group("2: "),
    Group("3: "),
    Group("4: ", matches=Match(wm_class=re.compile(r"^(md\.obsidian\.Obsidian)$")), layout="max"),
    Group("5: ", matches=Match(wm_class=re.compile(r"^(firefox)$")), layout="max"),
    Group("6: ", layout="max"),
    Group("7: ", matches=Match(wm_class=re.compile(r"^(vlc)$")), layout="max"),
    Group("8: ", matches=Match(wm_class=re.compile(r"^(transmission\-gtk)$")), layout="max"),
    Group("9: ", matches=Match(wm_class=re.compile(r"^(VirtualBox\ Manager|VirtualBox\ Machine|Gnome\-boxes|TelegramDesktop)$")), layout="max"),
    Group("10: ", matches=Match(wm_class=re.compile(r"^(org\.remmina\.Remmina|xfreerdp|gvncviewer|Google\-chrome)$")), layout="max"),

    ScratchPad("scratchpad", [
        DropDown("terminal", "alacritty", opacity=0.95, height=0.45),
    ])
]

for i in groups[:-1]: # без ScratchPad
    key = i.name.split(":")[0]
    key = key if len(key) == 1 else key[-1]
    name = i.name
    keys.extend(
        [
            Key([mod], key, lazy.group[name].toscreen(), desc=f"Переключиться на группу {name}"),
            Key([mod, "shift"], key, lazy.window.togroup(name, switch_group=True), desc=f"Переместить активное окно в группу {name}"),
        ]
    )


######### Раскладки #########

layouts = [
    layout.Columns(border_focus=[colors["gray"], colors["gray"]],
                   border_focus_stack=[colors["light_gray"], colors["light_gray"]],
                   border_normal=[colors["dark_gray"], colors["dark_gray"]],
                   border_normal_stack=[colors["dark_gray"], colors["dark_gray"]],
                   border_width=1,
                   margin=5),
    layout.Max(margin=1),
]

floating_layout = layout.Floating(
        float_rules=[
            # Класс и имя X-клиента можно посмотреть через `xprop`.
            *layout.Floating.default_float_rules,
            Match(wm_class=re.compile(r"^(Terminator|terminator)$")),
            Match(wm_class=r"^(Gnome\-screenshot)$"),
            Match(wm_class=re.compile(r"^(gnome\-calculator|org\.gnome\.Calculator)$")),
            Match(wm_class=re.compile(r"^(pinentry\-gtk|Pinentry\-gtk)$")),

            # Match(wm_class=r"^(Gvim)$"),
            # Match(wm_class=r"^(torbrowser\-launcher)$"),
            # Match(wm_class=r"^(isaac\-ng\.exe)$"),
        ],
        border_focus=[colors["gray"], colors["gray"]],
        border_normal=[colors["dark_gray"], colors["dark_gray"]],
        border_width=1
)


######### Панели #########

widget_defaults = {
    "font": "sans",
    "fontsize": 12,
    "padding": 3,
    "foreground": colors["light_blue"],
}
extension_defaults = widget_defaults.copy()

#
# Обёртки над виджетами
#

class MyGenPollText(widget.GenPollText):
    """
    widget.GenPollText с обновлением после клика (execute)
    """
    defaults = [
        ("execute", None, "Command to execute on click"),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(MyGenPollText.defaults)

        # Удобно вынести в переменную — так проще подменять при тестах
        self.execute_polling_interval = 0.1

        if self.execute:
            self.add_callbacks({"Button1": self.do_execute})

    def do_execute(self):
        self._process = subprocess.Popen(self.execute, shell=True)
        self.timeout_add(self.execute_polling_interval, self._refresh_count)

    def _refresh_count(self):
        if self._process.poll() is None:
            self.timeout_add(self.execute_polling_interval, self._refresh_count)
        else:
            self.timer_setup()


class MyVolume(widget.GenPollText):
    # """
    # widget.GenPollText для громкости; слово Muted выводится серым
    # """
    def update(self, text):
        super().update(text)
        if self.text == "Muted":
            self.text = "<span color='#757575'>Mute</span>"


class MyMemory(widget.Memory):
    """
    widget.Memory с {UsedShared} — это MemUsed + Shmem
    """
    def poll(self):
        mem = psutil.virtual_memory()
        swap = psutil.swap_memory()
        val = {}
        val["MemUsed"] = mem.used / self.calc_mem
        val["MemTotal"] = mem.total / self.calc_mem
        val["MemFree"] = mem.free / self.calc_mem
        val["MemPercent"] = mem.percent
        val["Buffers"] = mem.buffers / self.calc_mem
        val["Active"] = mem.active / self.calc_mem
        val["Inactive"] = mem.inactive / self.calc_mem
        val["Shmem"] = mem.shared / self.calc_mem
        val["Slab"] = mem.slab / self.calc_mem
        val["SwapTotal"] = swap.total / self.calc_swap
        val["SwapFree"] = swap.free / self.calc_swap
        val["SwapUsed"] = swap.used / self.calc_swap
        val["SwapPercent"] = swap.percent
        val["mm"] = self.measure_mem
        val["ms"] = self.measure_swap

        val["UsedShared"] = val["MemUsed"] + val["Shmem"]
        return self.format.format(**val)


class MyDF(widget.DF):
    """
    widget.DF с {us} — место, занятое пользователем
    """
    def poll(self):
        statvfs = os.statvfs(self.partition)

        size = statvfs.f_frsize * statvfs.f_blocks // self.calc
        free = statvfs.f_frsize * statvfs.f_bfree // self.calc
        self.user_free = statvfs.f_frsize * statvfs.f_bavail // self.calc

        if self.visible_on_warn and self.user_free >= self.warn_space:
            text = ""
        else:
            text = self.format.format(
                p=self.partition,
                s=size,
                f=free,
                uf=self.user_free,
                m=self.measure,
                r=(size - self.user_free) / size * 100,
                us=size - free,
            )
        return text


my_bar = bar.Bar(
    [
        # Слева
        widget.Spacer(length=5),
        widget.TextBox(fmt="<span color='#bd2c40'></span> {}",
                     mouse_callbacks = {"Button1": lambda: qtile.spawn("jgmenu_run")},
                     padding=1),

        widget.Sep(padding=3),
        widget.CurrentLayout(mode='icon',
                             scale=0.55,
                             padding=5),

        widget.Sep(padding=3),
        widget.Spacer(length=5),

        widget.TextBox(fmt="<span color='#ffb52a'></span> {}",
                     mouse_callbacks = {"Button1": lambda: qtile.spawn(f"{scripts['workspaces']} change"),
                                        "Button3": lambda: qtile.spawn(f"{scripts['workspaces']} move")},
                     padding=1),

        widget.Sep(padding=1),
        widget.Spacer(length=5),

        widget.GroupBox(hide_unused=True,
                        disable_drag=True,
                        borderwidth=1,
                        this_current_screen_border=colors['gray'],
                        padding=1),

        widget.Sep(padding=5),
        widget.Spacer(length=3),

        # По центру
        widget.TaskList(title_width_method="uniform",
                        foreground=colors["white"],
                        borderwidth=1,
                        border=colors['gray'],
                        padding=3),

        # Справа
        # клавиатурный аккорд: Мышь на клавиатуре
        widget.Chord(foreground=colors["light_blue"],
                     background=colors["red"],
                     padding=1),

        MyGenPollText(func=lambda: subprocess.check_output(scripts["keyboard"]).decode("utf-8").strip(),
                      execute=f"{scripts['keyboard']} change",
                      update_interval=1,
                      fmt="<span color='#bd2c40'></span> {}",
                      padding=1),
        # widget.KeyboardLayout(configured_keyboards=['us','ru'],
                              # display_map={'us':'us', 'ru':'ru'},
                              # fmt="<span color='#bd2c40'></span> {}",
                              # padding=1),

        widget.Sep(padding=5),
        MyVolume(func=lambda: subprocess.check_output(scripts["volume"]).decode("utf-8").strip(),
                      update_interval=0.1,
                      mouse_callbacks = {
                                         "Button1": lambda: qtile.spawn("pactl set-sink-mute 0 toggle"),
                                         "Button3": lambda: qtile.spawn(f"{scripts['volume']} change"),
                                         "Button4": lambda: qtile.spawn("pactl set-sink-volume 0 +2%"),
                                         "Button5": lambda: qtile.spawn("pactl set-sink-volume 0 -2%"),
                                         },
                      fmt="<span color='#ffb52a'></span> {}",
                      padding=3),

        widget.Sep(padding=5),
        MyGenPollText(func=lambda: subprocess.check_output(scripts["brightness"]).decode("utf-8").strip(),
                      execute=f"{scripts['brightness']} change",
                      update_interval=5,
                      fmt="<span color='#ffb52a'></span> {}",
                      padding=1),

        widget.Sep(padding=5),
        widget.ThermalSensor(foreground=colors["light_blue"],
                            tag_sensor='Package id 0',
                            # format='{tag}: {temp:.1f}{unit}',
                            fmt="<span color='#ffb52a'></span> {}",
                            padding=1),

        # widget.Sep(padding=5),
        # widget.CPU(format="{load_percent}%",
                   # fmt="<span color='#ffb52a'></span> {}",
                   # padding=1),

        widget.Sep(padding=5),
        MyMemory(format="{MemUsed: .2f}{mm} |{MemTotal: .2f}{mm}",
                      measure_mem="G",
                      mouse_callbacks = {"Button1": lambda: qtile.spawn("terminator -x htop")},
                      fmt="<span color='#ffb52a'></span>{}",
                      padding=1),

        widget.Sep(padding=5),
        MyDF(format="{us}{m} | {s}{m}",
                  visible_on_warn=False,
                  warn_space=10,
                  update_interval=10,
                  mouse_callbacks = {"Button1": lambda: qtile.spawn("terminator -x ncdu")},
                  fmt="<span color='#ffb52a'></span> {}",
                  padding=1),

        widget.Sep(padding=5),
        MyGenPollText(func=lambda: subprocess.check_output(scripts["singbox"]).decode("utf-8").strip(),
                      execute=f"{scripts['singbox']} change",
                      update_interval=5,
                      padding=1),
        # MyGenPollText(func=lambda: subprocess.check_output(scripts["wireguard"]).decode("utf-8").strip(),
                      # execute=f"{scripts['wireguard']} change",
                      # update_interval=5,
                      # padding=1),
        # MyGenPollText(func=lambda: subprocess.check_output(scripts["openvpn"]).decode("utf-8").strip(),
                      # execute=f"{scripts['openvpn']} change",
                      # update_interval=5,
                      # padding=1),

        widget.Sep(padding=5),
        widget.CheckUpdates(distro="Arch_yay",
                            execute="terminator -x yay -Su --removemake --cleanafter",
                            update_interval=600,
                            display_format = "{updates} Updates",
                            no_update_string="No Updates",
                            colour_have_updates=colors["yellow"],
                            colour_no_updates=colors["light_blue"],
                            fmt=" {}",
                            padding=1),

        widget.Sep(padding=5),
        widget.Clock(format="%A %Y-%m-%d %H:%M:%S",
                     mouse_callbacks = {"Button1": lambda: qtile.spawn("gsimplecal")},
                     fmt=" {}",
                     padding=1),

        widget.Sep(padding=5),
        widget.Systray(padding=1),
        widget.Spacer(length=5),

        # systray для X11 и StatusNotifier для Wayland
        # https://qtile-extras.readthedocs.io/en/stable/manual/ref/widgets.html#statusnotifier
        # yay -S qtile-extras python-dbus-fast

        # widget.Systray() \
        # if qtile.core.name == "x11" \
        # else widget.StatusNotifier(),
    ],
    background=colors["dark_gray"],
    size=25,
    margin=(1, 1, 1, 1),    # [С В Ю З]
    opacity=0.95,
)


######### Экраны #########

# Экран для X11 и Wayland
# Баг с обоями в X11:
# xcffib.ConnectionException при reload_config()
screens = [
    Screen(top=my_bar)
    if qtile.core.name == "x11" \
    else Screen(top=my_bar,
        wallpaper="/usr/share/backgrounds/archlinux/simple.png",
        wallpaper_mode="fill"
    )
]


######### Переменные конфигурации #########
# Документация: http://docs.qtile.org/en/latest/manual/config/index.html#configuration-variables

auto_fullscreen = True
bring_front_click = "floating_only"
cursor_warp = False
dgroups_app_rules = []
focus_on_window_activation = "urgent"
follow_mouse_focus = True
reconfigure_screens = True
auto_minimize = True
wmname = "Qtile"

