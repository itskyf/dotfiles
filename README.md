# Dotfiles

Adopt as [mise's global configuration](https://mise.jdx.dev/bootstrap/from-repository.html):

```sh
mise bootstrap --adopt itskyf/dotfiles
```

Update:

```sh
mise bootstrap --adopt itskyf/dotfiles --update
```

`~/.config/mise` must be absent, empty, or already this repository's checkout.
Move an unrelated existing configuration aside before adoption.
Only Git-tracked files are deployed from the `.config` and `.var` trees.
