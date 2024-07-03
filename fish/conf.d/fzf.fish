set -gx FZF_DEFAULT_COMMAND "fd -LHtf"
set -gx FZF_DEFAULT_OPTS \
    "--color=16,fg:-1,selected-fg:bright-cyan:bold,hl:red:bold,selected-hl:red:bold" \
    "--color=fg+:blue:bold,bg+:black,hl+:blue:bold,query:-1,disabled:grey,info:grey" \
    "--color=border:-1,separator:grey,header:grey:bold" \
    "--color=label:-1,prompt:red,pointer:blue,marker:bright-cyan,spinner:red" \
    "--border=sharp --preview-window=border-sharp --marker=+ --layout=reverse"

if [ $TERM = "linux" ]
    set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS" \
        "--prompt='> ' --pointer='>'"
else
    set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS" \
        "--prompt='→ ' --pointer=→"
end

bind \ef "fzf_inline file"
bind \ed "fzf_inline directory"
bind \eg "fzf_cd"
bind \ew "fzf_walker"
