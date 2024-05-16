function fish_user_key_bindings
    bind \b backward-kill-word
    bind \e\[3\;5~ kill-word
    bind \e\x7f kill-whole-line

    fzf_key_bindings
end
