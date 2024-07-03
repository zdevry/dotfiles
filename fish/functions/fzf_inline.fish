function fzf_inline
    if ! set -l dir (get_cursor_dir)
        fzf --height=40% --header="$dir is not a directory" < /dev/null
    else
        if [ -z "$dir" ]
            set -lx FZF_DEFAULT_COMMAND "fd -LHt $argv[1]"
            for file in (fzf --height=40% --multi)
                commandline -i (string escape --no-quoted -- "$file")
                commandline -i ' '
            end
        else
            set -lx FZF_DEFAULT_COMMAND "fd -LHt $argv[1] . $dir"
            commandline -tr ''
            for file in (fzf --height=40% --multi)
                commandline -i (string escape --no-quoted -- "$file"\
                    | string replace -r "^$HOME" "~")
                commandline -i ' '
            end
        end
    end

    commandline -f repaint
end
