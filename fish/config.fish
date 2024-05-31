set -gx MANPAGER "sh -c 'col -bx | bat -pl man'"
set -gx GROFF_NO_SGR 1
set -gx EDITOR micro

set -gx FZF_DEFAULT_COMMAND "fd -LH 2> /dev/null"

if status is-interactive
    set -gx FZF_ALT_C_COMMAND "fd -LHtd \$dir 2> /dev/null"
    set -gx FZF_CTRL_T_COMMAND "fd -LH \$dir 2> /dev/null"

    fzf_key_bindings
    
    bind \b backward-kill-word
    bind \e\[3\;5~ kill-word
    bind \e\x7f kill-whole-line
    bind \eS "commandline -i ' '"

    bind \cf fzf-file-widget
    bind \cj fzf-cd-widget
    
    alias ls "eza --icons"
    alias la "eza -la --icons --time-style=long-iso"
    abbr lstree "eza -RTL3 --icons"

    alias cp "cp -v"
    alias mv "mv -v"

    alias trash-put "trash-put -v"
    abbr rm "trash-put"

    abbr m micro
    abbr b bat
    abbr pacclear "paccache -ruk0; paccache -rk2"

    if [ $TERM = "alacritty" ]
        printf "\e[?1042l"
    end
end
