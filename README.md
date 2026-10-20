# Dotfiles

Install with mise's native global-config workflow:

```sh
mise bootstrap --adopt itskyf/dotfiles
```

Update the checkout and reapply:

```sh
mise bootstrap --adopt itskyf/dotfiles --update
```

The checkout lives at `~/.config/mise`. Global mise commands work from any
directory; repo-only dev tools and their lockfile live in `.mise/`.
Move an unrelated existing `~/.config/mise` aside before adoption.
Authenticate with GitHub first if cloning private repositories.
