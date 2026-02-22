set --global fish_greeting

if status is-login
    if type --query mise
        mise activate fish --shims | source
    end
end

if status is-interactive
    if test -n "$ANTIGRAVITY_AGENT"
        set --export TERM dumb
        set --export DEBIAN_FRONTEND noninteractive
        set --export PYTHONUNBUFFERED 1
        if type --query mise
            mise activate fish | source
        end
        return
    else
        if type --query mise
            mise activate fish | source
        end
        if type --query fnox
            fnox activate fish | source
        end
        if type --query fzf
            fzf --fish | source
        end
        if type --query starship
            starship init fish | source
        end
        if type --query zoxide
            zoxide init fish | source
        end

        # Human-specific exports
        set --export EDITOR "code --wait"
        set --export GPG_TTY (tty)
    end
end
