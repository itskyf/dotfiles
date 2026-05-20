if status is-interactive
    set fish_greeting ""
    fish_config theme choose catppuccin-mocha
    fnox activate fish | source
    starship init fish | source
    zoxide init fish | source
    if set --query XDG_RUNTIME_DIR
        set --global --export SSH_AUTH_SOCK (path normalize "$XDG_RUNTIME_DIR/bitwarden-ssh-agent.sock")
    end
end

