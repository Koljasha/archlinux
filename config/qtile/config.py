# Qtile config file
# Please see http://docs.qtile.org/en/latest/

import os
import subprocess

from libqtile import hook, layout, bar, widget, qtile
from libqtile.config import Key, Click, Drag, Group, Match, Screen
from libqtile.lazy import lazy
from libqtile.dgroups import simple_key_binder


######### Variables & functions #########

mod = "mod4"
alt = "mod1"

scripts = {
    "alacritty": os.path.expanduser("~/.config/qtile/scripts/shell.sh alacritty"),
    "terminator": os.path.expanduser("~/.config/qtile/scripts/shell.sh terminator"),
    "openvpn": os.path.expanduser("~/.config/qtile/scripts/openvpn.sh"),
    "openvpn_change": os.path.expanduser("~/.config/qtile/scripts/openvpn.sh change"),
    "brightness": os.path.expanduser("~/.config/qtile/scripts/brightness.sh"),
    "brightness_change": os.path.expanduser("~/.config/qtile/scripts/brightness.sh change"),
}

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

@hook.subscribe.startup_once
def autostart():
    path = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([path])


######### Keybindings #########

keys = [

    ######### Main #########

    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config Qtile"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),

    Key([mod, "control"], "p", lazy.shutdown(), desc="Shutdown Qtile"),

    ######### Menu #########

    Key([mod], "d", lazy.spawn("rofi -show run"), desc="Run rofi run"),
    Key([mod, "shift"], "d", lazy.spawn("rofi -show drun"), desc="Run rofi drun"),
    Key([mod], "Tab", lazy.spawn("rofi -show window"), desc="Run rofi window"),

    Key([mod], "grave", lazy.spawn("jgmenu_run"), desc="Run jgmenu"),

    ######### Window #########

    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    ######### Layouts #########

    Key([mod], "w", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "e", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

    Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod, "control"], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    ######### Workspaces #########

    # switch workspaces with Alt, Ctrl, Tab
    Key([alt], "Tab", lazy.screen.next_group(skip_empty=True), desc="Change groups"),
    Key([alt, "control"], "Left", lazy.screen.prev_group(skip_empty=True), desc="Change groups"),
    Key([alt, "control"], "Right", lazy.screen.next_group(skip_empty=True), desc="Change groups"),

    ######### Apps #########

    # Terminals
    Key([mod], "Return", lazy.spawn(scripts["alacritty"]), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn(scripts["terminator"]), desc="Launch terminal"),

    # Browser
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch browser"),

    # Screenshot
    Key([], "Print", lazy.spawn("gnome-screenshot --interactive"), desc="Make a screenshot"),

    # Volume control
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +2%"), desc="Volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -2%"), desc="Volume down"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle"), desc="Volume mute"),

    # KeyboardLayout
    Key([alt], "Shift_L", lazy.widget["keyboardlayout"].next_keyboard(), desc="Next keyboard layout."),

    # Vpn
    Key([mod, "shift"], "v", lazy.spawn(scripts["openvpn_change"]), desc="Start|Stop Vpn"),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]


######### Groups #########

groups = [
    Group("1: "),
    Group("2: "),
    Group("3: "),
    Group("4: ", matches=[Match(wm_class=["Pcmanfm"])], layout="max"),
    Group("5: ", matches=[Match(wm_class=["firefox"])], layout="max"),
    Group("6: "),
    Group("7: "),
    Group("8: "),
    Group("9: ", matches=[Match(wm_class=["vlc", "Transmission-gtk"])], layout="max"),
    Group("10: ", matches=[Match(wm_class=["org.remmina.Remmina"])], layout="max"),
]

dgroups_key_binder = simple_key_binder(mod)


######### Layouts #########

layouts = [
    layout.Columns(border_focus=[colors["gray"], colors["gray"]],
                   border_focus_stack=[colors["gray"], colors["light_gray"]],
                   border_normal=[colors["dark_gray"], colors["dark_gray"]],
                   border_normal_stack=[colors["dark_gray"], colors["dark_gray"]],
                   border_width=3,
                   margin=5),
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

floating_layout = layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,
            Match(wm_class="Terminator"),
            Match(wm_class="Gnome-calculator"),
            Match(wm_class="Gnome-screenshot"),
            Match(wm_class="isaac-ng.exe"),
        ],
        border_focus=[colors["gray"], colors["light_gray"]],
        border_normal=[colors["dark_gray"], colors["dark_gray"]],
        border_width=3
)


######### Bar #########

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
    foreground=colors["light_blue"],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=5),
                widget.Image(filename="~/.config/qtile/qtile.svg",
                             mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("jgmenu_run")}),
                widget.Spacer(length=5),
                widget.CurrentLayoutIcon(scale=0.8),
                widget.Spacer(length=5),
                widget.GroupBox(hide_unused=True,
                                disable_drag=True,
                                borderwidth=2),
                widget.Sep(),
                widget.Spacer(length=5),
                widget.TaskList(foreground=colors["white"]),
                widget.KeyboardLayout(configured_keyboards=["us","ru"],
                                      display_map={"us":"us", "ru":"ru"},
                                      fmt="<span color='#bd2c40'></span> {}"),
                widget.Sep(),
                widget.PulseVolume(update_interval=0.1,
                                   fmt="<span color='#ffb52a'></span> {}"),
                widget.Sep(),
                widget.GenPollText(func=lambda: subprocess.check_output(scripts["brightness"]).decode("utf-8").strip(),
                                   mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(scripts["brightness_change"])},
                                   update_interval=2,
                                   fmt="<span color='#ffb52a'></span> {}"),
                widget.Sep(),
                widget.Memory(format="{MemUsed: .2f}{mm} |{MemTotal: .2f}{mm}",
                              measure_mem="G",
                              mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("terminator -x htop")},
                              fmt="<span color='#ffb52a'></span>{}"),
                widget.Sep(),
                widget.DF(format="{uf}{m} | {s}{m} | {r:.2f}%",
                          visible_on_warn=False,
                          warn_space=10,
                          update_interval=10,
                          fmt="<span color='#ffb52a'></span> {}"),
                widget.Sep(),
                widget.CPU(format="{load_percent}%",
                           fmt="<span color='#ffb52a'></span> {}"),
                widget.Sep(),
                widget.ThermalSensor(foreground=colors["light_blue"],
                                    fmt="<span color='#ffb52a'></span> {}"),
                widget.Sep(),
                widget.GenPollText(func=lambda: subprocess.check_output(scripts["openvpn"]).decode("utf-8").strip(),
                                   mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn(scripts["openvpn_change"])},
                                   update_interval=2),
                widget.Sep(),
                widget.CheckUpdates(update_interval=1800,
                                    display_format = "{updates} Updates",
                                    no_update_string="No Updates",
                                    colour_have_updates=colors["yellow"],
                                    colour_no_updates=colors["light_blue"],
                                    mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("terminator -x yay")},
                                    fmt=" {}"),
                widget.Sep(),
                widget.Clock(format="%A %Y-%m-%d %H:%M:%S",
                             mouse_callbacks = {"Button1": lambda: qtile.cmd_spawn("gsimplecal")},
                             fmt=" {}"),
                widget.Sep(),
                widget.Systray(),
                widget.Spacer(length=5),
            ],
            background=colors["dark_gray"],
            size=25,
            margin=2,
            opacity=0.95,
        ),
    ),
]


######### Configuration variables #########
# http://docs.qtile.org/en/latest/manual/config/index.html#configuration-variables

auto_fullscreen = True
bring_front_click = "floating_only"
cursor_warp = True
dgroups_app_rules = []
focus_on_window_activation = "smart"
follow_mouse_focus = True
reconfigure_screens = True
auto_minimize = True
wmname = "Qtile"

