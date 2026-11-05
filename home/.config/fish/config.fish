if status is-interactive
    set --global fish_greeting ""

    fish_config theme choose --color-theme=dark catppuccin-mocha

    mise activate fish | source

    function _source_if_available --argument-names executable
        if type --query $executable
            $argv | source
        else
            printf 'Warning: %s is not installed.\n' $executable >&2
        end
    end

    _source_if_available fnox activate fish
    _source_if_available starship init fish
    _source_if_available zoxide init fish
    _source_if_available pitchfork activate fish

    functions --erase _source_if_available

    if test -n "$XDG_RUNTIME_DIR"
        set --local agent_socket "$XDG_RUNTIME_DIR/ssh-agent.socket"

        # if not test -S "$agent_socket"
        #     and set --query WSL_DISTRO_NAME
        #     set agent_socket "$XDG_RUNTIME_DIR/bitwarden-ssh-agent.sock"
        # end

        if test -S "$agent_socket"
            set --global --export SSH_AUTH_SOCK "$agent_socket"
        end
    end
else
    mise activate fish --shims | source
end
