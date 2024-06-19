#!/usr/bin/bash

export PATH="$PATH:$HOME/.local/bin:$HOME/dotfiles/scripts"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

[[ $(tty) != /dev/tty1 ]] && exec fish

echo -e "\e[32m\"fish\":\e[m shell only session"
echo -e "\e[32mEnter :\e[m sway desktop session"
echo

echo -en "\e[32msession ::\e[m "
read SESSION
STATUS_READ=$?
echo

if [[ $STATUS_READ != 0 ]] || [[ "$SESSION" == "fish" ]]; then
    exec fish
fi

export WLR_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"

random-theme-wallpaper.py $SESSION
sway --unsupported-gpu > /dev/null 2>&1
exec fish
