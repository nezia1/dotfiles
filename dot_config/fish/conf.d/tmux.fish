if status is-interactive
    and not set -q TMUX
    if command -v tmux > /dev/null
        exec tmux new-session -As base
    end
end

