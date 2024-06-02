function get_cursor_dir
    set -l cursor_token (commandline -ct | string unescape)
    set -l dir (string replace -r "^~" "$HOME" "$cursor_token")
    echo "$dir"
    [ ! -z "$dir" ] && [ ! -d "$dir" ] && return 1 || return 0
end
