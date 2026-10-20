# Dotfiles

Bootstrap from the repository:

```sh
mise bootstrap --from https://github.com/itskyf/dotfiles.git
```

Update the checkout and reapply:

```sh
mise bootstrap --from https://github.com/itskyf/dotfiles.git --update
```

Bootstrap copies `.config/mise/config.toml` to your global mise config, so
`mise bootstrap packages upgrade` works from any directory. Authenticate
Git before the first run if cloning private repositories.
