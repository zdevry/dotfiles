function fish_title
    if set -q argv[1]
        echo $argv[1]
    else
        prompt_pwd --dir-length 0
    end
end
