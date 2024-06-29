#!/usr/bin/env python3

import json, os, sys, random
from argparse import ArgumentParser
from subprocess import run

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

def link_wallpaper(wallpaper):
    wallpaper_dst = WALLPAPER_DIR + 'wallpaper'
    if os.path.islink(wallpaper_dst):
        os.unlink(wallpaper_dst)
    os.symlink(wallpaper, wallpaper_dst)

def set_wallpaper(wallpaper):
    print(f'Wallpaper: {wallpaper['short-desc']} ({wallpaper['filename']})')

    write_waybar_window_config(wallpaper['short-desc'])
    link_wallpaper(wallpaper['filename'])

def random_wallpaper(tags, wallpapers):
    for tag in tags:
        filter = True
        if tag.startswith('no-'):
            filter = False
            tag = tag[3::]
        wallpapers = [entry for entry in wallpapers if (tag in entry['tags']) == filter]

    if not wallpapers:
        print('No wallpapers found, retaining wallpaper from previous session...')
        sys.exit(1)

    return random.choice(wallpapers)

def get_wallpaper_direct(filename, wallpapers):
    for wallpaper in wallpapers:
        if wallpaper['filename'] == filename:
            return wallpaper
    print(f'Wallpaper {filename} does not exist, retaining wallpaper from previous session...')
    sys.exit(1)

def get_wallpaper_dmenu(dmenu_cmd, wallpapers):
    wallpaper_list = '\n'.join(f'{w['filename']}: {w['short-desc']}' for w in wallpapers)
    ret = run(dmenu_cmd.split(' '), capture_output=True, input=wallpaper_list, text=True)

    if ret.returncode != 0:
        print('Selection cancelled, retaining wallpaper from previous session...')
        sys.exit(1)
    return get_wallpaper_direct(ret.stdout.split(':')[0], wallpapers)

p = ArgumentParser()
g = p.add_mutually_exclusive_group()

g.add_argument('--tags', nargs='*', default=[])
g.add_argument('--wallpaper')
g.add_argument('--dmenu')

args = p.parse_args()

wallpapers = None
with open(WALLPAPER_DIR + 'wallpapers.json') as fwp:
    wallpapers = json.load(fwp)
if not wallpapers:
    print('wallpapers.json file does not exist')
    sys.exit(1)

if args.dmenu:
    set_wallpaper(get_wallpaper_dmenu(args.dmenu, wallpapers))
elif args.wallpaper:
    set_wallpaper(get_wallpaper_direct(args.wallpaper, wallpapers))
else:
    set_wallpaper(random_wallpaper(args.tags, wallpapers))
