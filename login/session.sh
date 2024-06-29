#!/usr/bin/bash

export PATH="$PATH:$HOME/.local/bin:$HOME/dotfiles/scripts"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

[[ $(tty) != /dev/tty1 ]] && exec fish

echo -e "\e[32m\"fish\":\e[m shell only session (fish)"
echo -e "\e[36mSway WM session:\e[m"
echo -e "\e[32mempty or tags:\e[m random wallpaper and theme"
echo -e "\e[32m\"retain\":\e[m retain wallpaper from previous session"
echo -e "\e[32m\"select\":\e[m select wallpaper from list"
echo

echo -en "\e[32msession ::\e[m "
read SESSION
STATUS_READ=$?
echo

if [[ $STATUS_READ != 0 ]] || [[ "$SESSION" == "fish" ]]; then
    exec fish
fi

export WLR_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1"

case "$SESSION" in
    retain);;
    select)
        FZF_DEFAULT_OPTS="--pointer='>'" random-wallpaper.py --dmenu "fzf --height=40% --layout=reverse"
        ;;
    *) random-wallpaper.py --tags $SESSION;;
esac

sway --unsupported-gpu > /dev/null 2>&1
exec fish
