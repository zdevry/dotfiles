#!/usr/bin/env python3

import json
import os
import sys
import random

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

WALLPAPER_DIR = os.getenv('HOME') + '/media/wallpapers/'

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
    print('No wallpapers found, skipping filter', file=sys.stderr)
    filtered_wallpapers = wallpapers

wallpaper = random.choice(filtered_wallpapers)

write_waybar_window_config(wallpaper['short-desc'])
print(wallpaper['filename'], wallpaper['theme'])
