function fzf_walker
    set -lx FZF_DEFAULT_COMMAND "echo '../'; fd -LHtd -d1;"
    while set dir (fzf --height=40% --header="$(prompt_pwd --dir-length 0)")
        cd -- "$dir"
    end
    commandline -f repaint
end
