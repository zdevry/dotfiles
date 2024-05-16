function ls
    eza -a $argv[1..]
end

function ll
    eza -loXh --no-permissions --time-style=long-iso $argv[1..]
end

function la
    eza -loXah --no-permissions --time-style=long-iso $argv[1..]
end

function lt
    eza -RT $argv[1..]
end
