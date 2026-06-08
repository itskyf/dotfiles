if status is-interactive
    set fish_greeting ""

    fish_config theme choose --color-theme=dark catppuccin-mocha

    fnox activate fish | source
    starship init fish | source

    if not set --query SSH_AUTH_SOCK
        and set --query WSL_DISTRO_NAME
        and set --query XDG_RUNTIME_DIR

        set --local bitwarden_ssh_agent_socket (path normalize "$XDG_RUNTIME_DIR/bitwarden-ssh-agent.sock")

        if test -S "$bitwarden_ssh_agent_socket"
            set --global --export SSH_AUTH_SOCK "$bitwarden_ssh_agent_socket"
        end
    end
end
