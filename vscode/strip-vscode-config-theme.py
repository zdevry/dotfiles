#!/usr/bin/env python3

import json
from os import getenv

def read_settings():
	homedir = getenv('HOME')
	settings_path = f'{homedir}/.config/Code/User/settings.json'

	with open(settings_path, 'r') as f:
		return json.load(f)

settings = read_settings()

settings.pop('workbench.colorTheme', None)
settings.pop('workbench.iconTheme', None)
settings.pop('window.zoomLevel', None)

print(json.dumps(settings, indent=4))
