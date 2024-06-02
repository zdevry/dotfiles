function fzf_inline
    if ! set -l dir (get_cursor_dir)
        fzf --height=40% --header="$dir is not a directory" < /dev/null
    else
        if [ -z "$dir" ]
            set -lx FZF_DEFAULT_COMMAND "fd -LHt $argv[1]"
            if set -l file (fzf --height=40%)
                commandline -i (string escape --no-quoted "$file")
            end
        else
            set -lx FZF_DEFAULT_COMMAND "fd -LHt $argv[1] . $dir"
            if set -l file (fzf --height=40%)
                commandline -i (string replace -r "^$dir" "" "$file"\
                    | string escape --no-quoted)
            end
        end
    end

    commandline -f repaint
end
