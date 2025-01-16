# Qtile config file
# Please see http://docs.qtile.org/en/latest/

import os
import re
import subprocess
import psutil

from libqtile import hook, layout, bar, widget, qtile
from libqtile.config import Key, KeyChord, Click, Drag, Group, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
# from libqtile.dgroups import simple_key_binder

if qtile.core.name == "wayland":
    from wlroots import ffi, lib
    from libqtile.backend.wayland import InputConfig

from libqtile.log_utils import logger

######### Variables & functions #########

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
    "picom_restart": os.path.expanduser("~/.config/scripts/picom_restart.sh"),

    "brightness": os.path.expanduser("~/.config/scripts/brightness.sh"),
    "password": os.path.expanduser("~/.config/scripts/password.sh"),
    "password_generate": os.path.expanduser("~/.config/scripts/password_generate.sh"),
    "volume": os.path.expanduser("~/.config/scripts/volume.sh"),
    "workspaces": os.path.expanduser("~/.config/scripts/workspaces.sh"),

    "keyboard": os.path.expanduser("~/.config/scripts/keyboard.sh"),
    "mouse_right_left": os.path.expanduser("~/.config/scripts/mouse_right_left.sh"),
    "mouse_scrolling_botton": os.path.expanduser("~/.config/scripts/mouse_scrolling_botton.sh"),
    "screenshot": os.path.expanduser("~/.config/scripts/screenshot.sh"),
    "updates": os.path.expanduser("~/.config/scripts/updates.sh"),

    "openvpn": os.path.expanduser("~/.config/scripts/vpn_openvpn.sh"),
    "wireguard": os.path.expanduser("~/.config/scripts/vpn_wireguard.sh"),
}

@hook.subscribe.startup_once
def autostart():
    subprocess.run([scripts["autostart"]])

@lazy.function
def increase_gaps(qtile):
    qtile.current_layout.margin += 5
    qtile.current_group.layout_all()

@lazy.function
def decrease_gaps(qtile):
    qtile.current_layout.margin = qtile.current_layout.margin-5 if qtile.current_layout.margin-5 > 0 else 0
    qtile.current_group.layout_all()

@lazy.function
def move_prev_group(qtile):
    groups = qtile.groups[:-1] # without ScratchPad
    index =  groups.index(qtile.current_group)
    index = len(groups)-1 if index == 0 else index-1
    qtile.current_window.togroup(groups[index].name, switch_group=True)

@lazy.function
def move_next_group(qtile):
    groups = qtile.groups[:-1] # without ScratchPad
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
            atom = set([qtile.core.conn.atoms["_NET_WM_STATE_DEMANDS_ATTENTION"]])
            prev_state = set(window.window.get_property("_NET_WM_STATE", "ATOM", unpack=int))
            new_state = prev_state | atom
            window.window.set_property("_NET_WM_STATE", list(new_state))

# https://docs.qtile.org/en/latest/manual/wayland.html
if qtile.core.name == "wayland":
    # show inputs: qtile cmd-obj -o core -f get_inputs
    wl_input_rules = {
        "1149:4128:Kensington Expert Mouse": InputConfig(
            pointer_accel=0.10,
            scroll_method='on_button_down',
            scroll_button='Button3',
        ),
        # other (example config for Elecom)
        "type:pointer": InputConfig(
            pointer_accel=-0.30,
            scroll_method='on_button_down',
            scroll_button='Button9',
        ),
    }

    def get_keyboard_layout():
        for device in qtile.core.keyboards[:1]:
            # keymap = device.wlr_device.keyboard._ptr.keymap
            keymap = device.keyboard._ptr.keymap
            name = lib.xkb_keymap_layout_get_name(keymap, 0)
            layout = ffi.string(name).decode()
            if layout == "Russian":
                return "ru"
            else:
                return "us"

    @lazy.function
    def set_keyboard_layout(qtile):
        for device in qtile.core.keyboards[:1]:
            # keymap = device.wlr_device.keyboard._ptr.keymap
            keymap = device.keyboard._ptr.keymap
            name = lib.xkb_keymap_layout_get_name(keymap, 0)
            layout = ffi.string(name).decode()
            if layout == "Russian":
                qtile.spawn("qtile cmd-obj -o core -f set_keymap -a us,ru grp:alt_shift_toggle")
            else:
                qtile.spawn("qtile cmd-obj -o core -f set_keymap -a ru,us grp:alt_shift_toggle")

######### Keybindings #########

keys = [

    ######### Main #########

    # Kill window
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),

    # Reload | Restart Qtile
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config Qtile"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),

    # Exit menu
    Key([mod, "shift"], "p", lazy.spawn(scripts["power"]), desc="Exit | Reboot | Poweroff"),
    Key([mod, "control"], "p", lazy.shutdown(), desc="Shutdown Qtile"),

    # Picom restart
    Key([mod], "p", lazy.spawn(scripts["picom_restart"]), desc="Restart Picom"),
    # Kill window
    Key([alt, "control"], "Delete", lazy.spawn("xkill"), desc="Kill window"),
    # Reboot System
    Key([mod, alt, "control"], "Delete", lazy.spawn("systemctl -i reboot"), desc="Reboot System"),
    # Change background
    Key([mod], "o", lazy.spawn("systemctl --user start setbg.service"), desc="Change background"),
    # Change mouse hand
    Key([mod, "control"], "m", lazy.spawn(scripts["mouse_right_left"]), desc="Change mouse left|right hand"),
    # Change mouse scrolling button
    Key([mod, "shift"], "m", lazy.spawn(scripts["mouse_scrolling_botton"]), desc="Change mouse scrolling button"),

    ######### Menu #########

    Key([mod], "d", lazy.spawn("dmenu_run -b -i"), desc="Run dmenu run"),

    Key([mod], "grave", lazy.spawn("jgmenu_run"), desc="Run jgmenu"),

    Key([mod], "a", lazy.spawn("rofi -show drun"), desc="Run rofi drun"),
    Key([mod, "shift"], "a", lazy.spawn("rofi -show run"), desc="Run rofi run"),
    Key([mod], "Tab", lazy.spawn("rofi -show window"), desc="Run rofi window"),

    # Brightness
    Key([mod, "shift"], "z", lazy.spawn(f"{scripts['brightness']} change"), desc="Change brightness"),

    # Clipboard
    Key([mod], "c", lazy.spawn("clipmenu"), desc="Show clipboard history"),

    # Password
    Key([mod], "s", lazy.spawn(scripts["password"]), desc="Run menu for pass"),
    Key([mod, "shift"], "s", lazy.spawn(scripts["password_generate"]), desc="Run menu for generate pass"),

    # Volume
    Key([mod], "z", lazy.spawn(f"{scripts['volume']} change"), desc="Change volume"),

    # Workspaces
    Key([mod], "x", lazy.spawn(f"{scripts['workspaces']} change"), desc="Change workspaces"),
    Key([mod, "shift"], "x", lazy.spawn(f"{scripts['workspaces']} move"), desc="Move to workspaces"),

    ######### System #########

    # Volume control
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%"), desc="Volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%"), desc="Volume down"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle"), desc="Volume mute"),

    # Screenshot
    Key([], "Print", lazy.spawn(f"{scripts['screenshot']} full"), desc="Make a screenshot"),
    Key([mod], "Print", lazy.spawn(f"{scripts['screenshot']} region"), desc="Make a screenshot"),
    Key([mod, "shift"], "Print", lazy.spawn(f"{scripts['screenshot']} edit"), desc="Make a screenshot"),
    # Key([], "Print", lazy.spawn("gnome-screenshot --interactive"), desc="Make a screenshot"),

    # Notifications
    Key([mod, "shift"], "n", lazy.spawn("dunstctl close-all"), desc="Close notifications"),
    Key([mod, "control"], "n", lazy.spawn("dunstctl history-pop"), desc="Show notifications history"),

    # Vpn
    # Key([mod, "shift"], "v", lazy.spawn(f"{scripts['openvpn']} change"), desc="Start|Stop Vpn"),
    Key([mod, "shift"], "v", lazy.spawn(f"{scripts['wireguard']} change"), desc="Start|Stop Vpn"),

    # System updates
    Key([mod, "shift"], "u", lazy.spawn(scripts["updates"]), desc="System updates"),

    ######### Apps #########

    # Terminal
    Key([mod], "Return", lazy.spawn(f"{scripts['shell']} alacritty"), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn(f"{scripts['shell']} terminator"), desc="Launch terminal"),

    Key([mod, "control"], "Return", lazy.spawn("alacritty --command ranger"), desc="Launch terminal"),

    # Browser
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch browser"),

    # Run htop
    Key([mod], "t", lazy.spawn("terminator -x htop"), desc="Run htop"),

    # Fn keys
    Key([], "XF86Explorer", lazy.spawn("pcmanfm"), desc="PcManFm"),
    # Key([], "XF86Search", lazy.spawn("remmina"), desc="Remmina"),
    Key([], "XF86Search", lazy.spawn("google-chrome-stable"), desc="Google Chrome"),
    Key([], "XF86Calculator", lazy.spawn("gnome-calculator"), desc="Calculator"),
    Key([], "XF86Tools", lazy.spawn("evim"), desc="Editor"),

    ######### Window #########

    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    # or
    KeyChord([mod, "shift"], "space", [
            Key([], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
            Key([], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
            Key([], "Down", lazy.layout.grow_down(), desc="Grow window down"),
            Key([], "j", lazy.layout.grow_down(), desc="Grow window down"),
            Key([], "Up", lazy.layout.grow_up(), desc="Grow window up"),
            Key([], "k", lazy.layout.grow_up(), desc="Grow window up"),
            Key([], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
            Key([], "l", lazy.layout.grow_right(), desc="Grow window to the right"),

            Key([], "Return", lazy.ungrab_chord()), # for exit chord like Esc
            Key([mod, "shift"], "space", lazy.ungrab_chord()), # for exit chord like Esc
            ],
            mode=True,
            name="  " ,
        ),

    Key([mod], "space", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([alt], "Tab", lazy.layout.next(), desc="Move window focus to other window"),

    Key([mod], "m", toggle_minimize(), desc="Toggle minimize windows"),

    ######### Layouts #########

    Key([mod], "w", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "e", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod, "control"], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    KeyChord([mod, "control"], "space", [
            Key([], "Down", increase_gaps(), desc="Increase Gaps"),
            Key([], "Right", increase_gaps(), desc="Increase Gaps"),
            Key([], "Up", decrease_gaps(), desc="Decrease Gaps"),
            Key([], "Left", decrease_gaps(), desc="Decrease Gaps"),

            Key([], "Return", lazy.ungrab_chord()), # for exit chord like Esc
            Key([mod, "control"], "space", lazy.ungrab_chord()), # for exit chord like Esc
            ],
            mode=True,
            name="  " ,
        ),

    ######### Workspaces #########

    Key([alt, "control"], "Left", lazy.screen.prev_group(skip_empty=True), desc="Change groups"),
    Key([alt, "control"], "h", lazy.screen.prev_group(skip_empty=True), desc="Change groups"),
    Key([alt, "control"], "Right", lazy.screen.next_group(skip_empty=True), desc="Change groups"),
    Key([alt, "control"], "l", lazy.screen.next_group(skip_empty=True), desc="Change groups"),

    Key([alt, "control"], "Down", move_prev_group(), desc="Move window to prev group"),
    Key([alt, "control"], "j", move_prev_group(), desc="Move window to prev group"),
    Key([alt, "control"], "Up", move_next_group(), desc="Move window to next group"),
    Key([alt, "control"], "k", move_next_group(), desc="Move window to next group"),

    Key([mod], "backspace", lazy.group["scratchpad"].dropdown_toggle("terminal"), desc="ScratchPad"),

    ######### Mouse on the keyboard #########

    KeyChord([mod], "Home", [
            Key([], "Left", lazy.spawn("xdotool mousemove_relative -- -50 0"), desc="Mouse left"),
            Key(["shift"], "Left", lazy.spawn("xdotool mousemove_relative -- -10 0"), desc="Mouse left"),
            Key(["control"], "Left", lazy.spawn("xdotool mousemove_relative -- -250 0"), desc="Mouse left"),

            Key([], "Right", lazy.spawn("xdotool mousemove_relative -- 50 0"), desc="Mouse right"),
            Key(["shift"], "Right", lazy.spawn("xdotool mousemove_relative -- 10 0"), desc="Mouse right"),
            Key(["control"], "Right", lazy.spawn("xdotool mousemove_relative -- 250 0"), desc="Mouse right"),

            Key([], "Up", lazy.spawn("xdotool mousemove_relative -- 0 -50"), desc="Mouse up"),
            Key(["shift"], "Up", lazy.spawn("xdotool mousemove_relative -- 0 -10"), desc="Mouse up"),
            Key(["control"], "Up", lazy.spawn("xdotool mousemove_relative -- 0 -250"), desc="Mouse up"),

            Key([], "Down", lazy.spawn("xdotool mousemove_relative -- 0 50"), desc="Mouse down"),
            Key(["shift"], "Down", lazy.spawn("xdotool mousemove_relative -- 0 10"), desc="Mouse down"),
            Key(["control"], "Down", lazy.spawn("xdotool mousemove_relative -- 0 250"), desc="Mouse down"),

            Key([], "Return", lazy.spawn("xdotool click 1"), desc="Mouse left click"),
            Key([], "Page_Up", lazy.spawn("xdotool click 4"), desc="Mouse wheel up"),
            Key([], "Page_Down", lazy.spawn("xdotool click 5"), desc="Mouse wheel down"),
            Key([], "Insert", lazy.spawn("xdotool click 9"), desc="Mouse additional button"),
            Key([], "Delete", lazy.spawn("xdotool click 8"), desc="Mouse additional button"),

            Key([mod], "Home", lazy.ungrab_chord()), # for exit chord like Esc
            ],
            mode=True,
            name="  ",
        ),
]

if qtile.core.name == "wayland":
    keys.extend(
        [
        Key([alt], "Shift_L", set_keyboard_layout(), desc="Change keyboard layout"),
        ]
    )

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button4", lazy.window.bring_to_front())
]


######### Groups #########

groups = [
    Group("1: "),
    Group("2: "),
    Group("3: "),
    Group("4: "),
    Group("5: ", matches=Match(wm_class=re.compile(r"^(firefox)$")), layout="max"),
    Group("6: ", layout="max"),
    Group("7: ", matches=Match(wm_class=re.compile(r"^(vlc)$")), layout="max"),
    Group("8: ", matches=Match(wm_class=re.compile(r"^(transmission\-gtk)$")), layout="max"),
    Group("9: ", matches=Match(wm_class=re.compile(r"^(VirtualBox\ Manager|VirtualBox\ Machine|Gnome\-boxes)$")), layout="max"),
    Group("10: ", matches=Match(wm_class=re.compile(r"^(org\.remmina\.Remmina|xfreerdp|Google\-chrome)$")), layout="max"),

    ScratchPad("scratchpad", [
        DropDown("terminal", "alacritty", opacity=0.95, height=0.45),
    ])
]

# dgroups_key_binder = simple_key_binder(mod)   # error change https://github.com/qtile/qtile/issues/4024

for i in groups[:-1]: # without ScratchPad
    key = i.name.split(":")[0]
    key = key if len(key) == 1 else key[-1]
    name = i.name
    keys.extend(
        [
            Key([mod], key, lazy.group[name].toscreen(), desc=f"Switch to group {name}"),
            Key([mod, "shift"], key, lazy.window.togroup(name, switch_group=True), desc=f"Move focused window to group {name}"),
        ]
    )


######### Layouts #########

layouts = [
    layout.Columns(border_focus=[colors["gray"], colors["gray"]],
                   border_focus_stack=[colors["light_gray"], colors["light_gray"]],
                   border_normal=[colors["dark_gray"], colors["dark_gray"]],
                   border_normal_stack=[colors["dark_gray"], colors["dark_gray"]],
                   border_width=1,
                   margin=5),
    layout.Max(margin=1),

    # layout.Floating(),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Slice(),
    # layout.Stack(num_stacks=2),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

floating_layout = layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class=re.compile(r"^(Terminator|terminator)$")),
            Match(wm_class=r"^(Gvim)$"),
            Match(wm_class=re.compile(r"^(gnome\-calculator|org\.gnome\.Calculator)$")),
            Match(wm_class=re.compile(r"^(pinentry\-gtk|Pinentry\-gtk)$")),
            Match(wm_class=r"^(Gnome\-screenshot)$"),
            Match(wm_class=r"^(torbrowser\-launcher)$"),
            Match(wm_class=r"^(isaac\-ng\.exe)$"),
        ],
        border_focus=[colors["gray"], colors["gray"]],
        border_normal=[colors["dark_gray"], colors["dark_gray"]],
        border_width=1
)


######### Bars #########

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
    foreground=colors["light_blue"],
)
extension_defaults = widget_defaults.copy()

#
# Wrappers on widgets
#

# class MyPulseVolume(widget.PulseVolume):
    # """
    # widget.PulseVolume with gray word "Mute""
    #
    # needed `python-pulsectl-asyncio` but it olded in AUR
    # https://github.com/qtile/qtile/issues/4495#issuecomment-1752460875
    # """
    # def _update_drawer(self):
        # super()._update_drawer()
        # if self.text == "M":
            # self.text = "<span color='#757575'>Mute</span>"


class MyVolume(widget.GenPollText):
    # """
    # widget.GenPollText for Volume control with gray word for Muted
    # """
    def update(self, text):
        super().update(text)
        if self.text == "Muted":
            self.text = "<span color='#757575'>Mute</span>"


class MyGenPollText(widget.GenPollText):
    """
    widget.GenPollText with update after clicking execute
    """
    defaults = [
        ("execute", None, "Command to execute on click"),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(MyGenPollText.defaults)

        # Helpful to have this as a variable as we can shorten it for testing
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


class MyMemory(widget.Memory):
    """
    widget.Memory with {UsedShared} - MemUsed+Shmem
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
    widget.DF with {us} - user space
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


class MyKeyboardLayout(widget.GenPollText):
    """
    widget.GenPollText for show and change keyboard layout
    use for Qtile Wayland session
    """
    defaults = [
        ("execute", None, "Command to execute on click"),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(MyKeyboardLayout.defaults)
        self.add_callbacks(
            { "Button1": self.execute, }
        )


my_bar = bar.Bar(
    [
        # Left
        widget.Spacer(length=5),
        widget.TextBox(fmt="<span color='#bd2c40'></span> {}",
                     mouse_callbacks = {"Button1": lambda: qtile.spawn("jgmenu_run")}),

        widget.Sep(padding=3),
        widget.CurrentLayoutIcon(scale=0.55),

        widget.Sep(padding=3),
        widget.Spacer(length=5),

        widget.TextBox(fmt="<span color='#ffb52a'></span> {}",
                     mouse_callbacks = {"Button1": lambda: qtile.spawn(f"{scripts['workspaces']} change"),
                                        "Button3": lambda: qtile.spawn(f"{scripts['workspaces']} move")}),

        widget.Sep(padding=1),
        widget.Spacer(length=5),

        widget.GroupBox(hide_unused=True,
                        disable_drag=True,
                        borderwidth=1,
                        this_current_screen_border=colors['gray']),

        widget.Sep(padding=5),
        widget.Spacer(length=3),

        # Center
        widget.TaskList(title_width_method="uniform",
                        foreground=colors["white"],
                        borderwidth=1,
                        border=colors['gray']),

        # Right
        # keyboard chord and layout for X11 and Wayland
        widget.Chord(foreground=colors["light_blue"], background=colors["red"]),
        MyGenPollText(func=lambda: subprocess.check_output(scripts["keyboard"]).decode("utf-8").strip(),
                      execute=f"{scripts['keyboard']} change",
                      update_interval=1,
                      fmt="<span color='#bd2c40'></span> {}") \
        if qtile.core.name == "x11" \
        else MyKeyboardLayout(func=get_keyboard_layout,
                         execute=set_keyboard_layout(),
                         update_interval=0.5,
                         fmt="<span color='#bd2c40'></span> {}"),

        widget.Sep(padding=5),
        MyVolume(func=lambda: subprocess.check_output(scripts["volume"]).decode("utf-8").strip(),
                      update_interval=0.1,
                      mouse_callbacks = {
                                         "Button1": lambda: qtile.spawn("pactl set-sink-mute 0 toggle"),
                                         "Button3": lambda: qtile.spawn(f"{scripts['volume']} change"),
                                         "Button4": lambda: qtile.spawn("pactl set-sink-volume 0 +2%"),
                                         "Button5": lambda: qtile.spawn("pactl set-sink-volume 0 -2%"),
                                         },
                      fmt="<span color='#ffb52a'></span> {}"),
        # MyPulseVolume(update_interval=0.1,
                      # mouse_callbacks = { "Button3": lambda: qtile.spawn(f"{scripts['volume']} change") },
                      # fmt="<span color='#ffb52a'></span> {}"),

        widget.Sep(padding=5),
        MyGenPollText(func=lambda: subprocess.check_output(scripts["brightness"]).decode("utf-8").strip(),
                      execute=f"{scripts['brightness']} change",
                      update_interval=5,
                      fmt="<span color='#ffb52a'></span> {}"),

        widget.Sep(padding=5),
        MyMemory(format="{UsedShared: .2f}{mm} |{MemTotal: .2f}{mm}",
                      measure_mem="G",
                      mouse_callbacks = {"Button1": lambda: qtile.spawn("terminator -x htop")},
                      fmt="<span color='#ffb52a'></span>{}"),

        widget.Sep(padding=5),
        MyDF(format="{us}{m} | {s}{m}",
                  visible_on_warn=False,
                  warn_space=10,
                  update_interval=10,
                  mouse_callbacks = {"Button1": lambda: qtile.spawn("terminator -x ncdu")},
                  fmt="<span color='#ffb52a'></span> {}"),

        widget.Sep(padding=5),
        # widget.CPU(format="{load_percent}%",
                   # fmt="<span color='#ffb52a'></span> {}"),
        # widget.Sep(padding=5),
        # widget.ThermalSensor(foreground=colors["light_blue"],
                            # fmt="<span color='#ffb52a'></span> {}"),
        # widget.Sep(padding=5),
        # MyGenPollText(func=lambda: subprocess.check_output(scripts["openvpn"]).decode("utf-8").strip(),
                      # execute=f"{scripts['openvpn']} change",
                      # update_interval=5),
        MyGenPollText(func=lambda: subprocess.check_output(scripts["wireguard"]).decode("utf-8").strip(),
                      execute=f"{scripts['wireguard']} change",
                      update_interval=5),

        widget.Sep(padding=5),
        widget.CheckUpdates(distro="Arch_yay",
                            execute="terminator -x yay -Su --removemake --cleanafter",
                            update_interval=600,
                            display_format = "{updates} Updates",
                            no_update_string="No Updates",
                            colour_have_updates=colors["yellow"],
                            colour_no_updates=colors["light_blue"],
                            fmt=" {}"),

        widget.Sep(padding=5),
        widget.Clock(format="%A %Y-%m-%d %H:%M:%S",
                     mouse_callbacks = {"Button1": lambda: qtile.spawn("gsimplecal")},
                     fmt=" {}"),

        widget.Sep(padding=5),
        # systray for X11 and Wayland
        widget.Systray() \
        if qtile.core.name == "x11" \
        else widget.StatusNotifier(),    # see qtile-extras
        widget.Spacer(length=5),
    ],
    background=colors["dark_gray"],
    size=25,
    margin=(1, 1, 1, 1),    # [N E S W]
    opacity=0.95,
)


######### Screens #########

# Screen for X11 and Wayland
# Bug when wallpaper in X11:
# xcffib.ConnectionException when reload_config()
screens = [
    Screen(top=my_bar)
    if qtile.core.name == "x11" \
    else Screen(top=my_bar,
        wallpaper="/usr/share/backgrounds/archlinux/simple.png",
        wallpaper_mode="fill"
    )
]


######### Configuration variables #########
# http://docs.qtile.org/en/latest/manual/config/index.html#configuration-variables

auto_fullscreen = True
bring_front_click = "floating_only"
cursor_warp = False
dgroups_app_rules = []
focus_on_window_activation = "urgent"
follow_mouse_focus = True
reconfigure_screens = True
auto_minimize = True
wmname = "Qtile"

