function fzf_cd
    if ! set -l dir (get_cursor_dir)
        fzf --height=40% --header="$dir is not a directory" < /dev/null
    else
        [ -z "$dir" ] \
            && set -lx FZF_DEFAULT_COMMAND "fd -LHtd" \
            || set -lx FZF_DEFAULT_COMMAND "fd -LHtd . $dir"
        if set -l directory (fzf --height=40%)
            cd -- "$directory"
            commandline -b ""
        end
    end

    commandline -f repaint
end
