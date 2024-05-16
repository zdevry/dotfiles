function fish_prompt
    set previous_status $status

    set err_code_color (set_color brblack)
    if [ $previous_status != 0 ]
        set err_code_color (set_color -o brred)
    end

    echo -n $err_code_color"∴ $previous_status$(set_color normal) "
    echo -n "$(set_color green)$(prompt_pwd --dir-length 0) "
    echo -n "$(set_color blue -o)→ $(set_color normal)"
end
