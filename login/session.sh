#!/usr/bin/bash

echo -e "\e[32m\"fish\":\e[m shell only session"
echo -e "\e[32mEnter :\e[m sway desktop session"
echo

echo -en "\e[32msession ::\e[m "
read SESSION
STATUS_READ=$?
echo

export PATH="$PATH:$HOME/.local/bin:$HOME/dotfiles/scripts"
export NVD_BACKEND=direct
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

if [[ $STATUS_READ != 0 ]] || [[ "$SESSION" == "fish" ]]; then
    exec fish
fi

export WLR_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"

WALLPAPER_DIR="$HOME/media/wallpapers"
WALLPAPER_ENTRY=$(random-theme-wallpaper.py $SESSION)
WALLPAPER_FILENAME=$(cut -d' ' -f1 <<< "$WALLPAPER_ENTRY")
THEME=$(cut -d' ' -f2 <<< "$WALLPAPER_ENTRY")

[[ -L "$WALLPAPER_DIR/wallpaper" ]] && unlink "$WALLPAPER_DIR/wallpaper"
ln -s "$WALLPAPER_FILENAME" "$WALLPAPER_DIR/wallpaper"
desktop-set-theme "$THEME" > /dev/null 2>&1

sway --unsupported-gpu > /dev/null 2>&1
exec fish
