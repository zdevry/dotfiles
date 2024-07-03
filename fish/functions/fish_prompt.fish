function fish_prompt
    set -l previous_status $status

    set -l err_code_color (set_color brblack)
    if [ $previous_status != 0 ]
        set err_code_color (set_color -o brred)
    end

    set -l cwd (prompt_pwd --dir-length 0)

    if [ "$TERM" != "linux" ]
        echo -n $err_code_color"∴ $previous_status$(set_color normal) "
        echo -n "$(set_color green)󰉋 $cwd"

        if [ (string length "$cwd") -gt 50 ]
            echo -en "\n "
        else
            echo -n " "
        end
        
        echo -n "$(set_color blue -o)→ $(set_color normal)"
    else
        echo -n $err_code_color"[$previous_status]$(set_color normal) "
        echo -n "$(set_color green)$cwd "
        echo -n "$(set_color blue -o)\$ $(set_color normal)"
    end
end
