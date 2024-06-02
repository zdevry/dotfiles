#!/usr/bin/bash

echo -e "\e[32mEnter/Space:\e[m sway desktop session"
echo -e "\e[32many other key:\e[m shell only session"
echo

echo -en "\e[32msession ::\e[m "
read -n 1 KEY
STATUS_READ="$?"
echo

export PATH="$PATH:$HOME/.local/bin:$HOME/dotfiles/scripts"
export NVD_BACKEND=direct
eval "$(ssh-agent)" > /dev/null

if [[ $STATUS_READ == 0 ]] && [[ -z "$KEY" ]]; then
    export WLR_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"
    sway --unsupported-gpu > /dev/null
fi

exec fish
