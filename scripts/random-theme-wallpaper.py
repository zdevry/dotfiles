#!/usr/bin/env python3

import json, os, sys, random

WALLPAPER_DIR = os.getenv('HOME') + '/media/wallpapers/'

def write_waybar_window_config(desc):
    waybar_window_conf = os.getenv('HOME') + '/dotfiles/waybar/window.jsonc'
    config = {
        "modules-center": ["sway/window"],
        "sway/window": {
            "max-length": 50,
            "on-click": "rofi -show window",
            "on-click-middle": "rofi -show drun",
            "on-click-right": "rofi-sway-window-menu",
            "rewrite": {
                "^$": desc
            }
        }
    }

    with open(waybar_window_conf, 'w') as f:
        json.dump(config, f, indent=4)

def link_colours(colour_theme):
    DOTFILES_DIR = os.getenv('HOME') + '/dotfiles/'
    ext_by_conf = {
        'sway/': '.conf',
        'swaync/': '.css',
        'waybar/': '.css',
        'rofi/': '.rasi',
        'alacritty/': '.toml'
    }

    for conf in ext_by_conf:
        dst_link = DOTFILES_DIR + conf + "colours" + ext_by_conf[conf]

        if os.path.islink(dst_link):
            os.unlink(dst_link)
        os.symlink(colour_theme + ext_by_conf[conf], dst_link)

def link_wallpaper(wallpaper):
    wallpaper_dst = WALLPAPER_DIR + 'wallpaper'
    if os.path.islink(wallpaper_dst):
        os.unlink(wallpaper_dst)
    os.symlink(wallpaper, wallpaper_dst)


wallpapers = None
with open(WALLPAPER_DIR + 'wallpapers.json') as fwp:
    wallpapers = json.load(fwp)

tags = sys.argv[1::]
filtered_wallpapers = wallpapers.copy()

for tag in tags:
    filter = True
    if tag.startswith('no-'):
        filter = False
        tag = tag[3::]
    filtered_wallpapers = [entry for entry in filtered_wallpapers if (tag in entry['tags']) == filter]

if not filtered_wallpapers:
    print('No wallpapers found, skipping filter')
    filtered_wallpapers = wallpapers

wallpaper = random.choice(filtered_wallpapers)

print(f'Wallpaper: {wallpaper['short-desc']} ({wallpaper['filename']}), theme: {wallpaper['theme']}')

write_waybar_window_config(wallpaper['short-desc'])
link_wallpaper(wallpaper['filename'])
link_colours(wallpaper['theme'])
