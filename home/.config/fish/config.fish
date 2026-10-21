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

    if set --query WSL_DISTRO_NAME
        if not set --query SSH_AUTH_SOCK
            and set --query XDG_RUNTIME_DIR

            set --local bitwarden_ssh_agent_socket "$XDG_RUNTIME_DIR/bitwarden-ssh-agent.sock"

            if test -S "$bitwarden_ssh_agent_socket"
                set --global --export SSH_AUTH_SOCK "$bitwarden_ssh_agent_socket"
            end
        end
    else
        set --global --export SSH_AUTH_SOCK "$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"
    end
else
    mise activate fish --shims | source
end
