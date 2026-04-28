if status is-interactive
    set fish_greeting ""
    fish_config theme choose catppuccin-mocha
    fnox activate fish | source
    starship init fish | source
    zoxide init fish | source
end
