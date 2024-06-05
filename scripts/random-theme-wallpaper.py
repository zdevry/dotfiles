#!/usr/bin/env python3

import json
import os
import sys
import random

WALLPAPER_DIR = os.getenv('HOME') + '/media/image/wallpaper-vault/'

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

print(wallpaper['filename'], wallpaper['theme'])