# Dotfiles

This repository is the machine's global mise configuration. Bootstrap with
mise's native [`--adopt`](https://mise.jdx.dev/bootstrap/from-repository.html#global-mise-configuration):

```sh
mise bootstrap --adopt itskyf/dotfiles
```

mise clones the repository to `$MISE_CONFIG_DIR` (normally
`~/.config/mise`). Its root `config.toml` becomes the global config;
`mise.toml` stays project-specific.

The [dotfiles](https://mise.jdx.dev/dotfiles/managed.html) configuration uses
sources relative to this repository. The `.config` and `.var` trees use
`symlink-each` with `manifest = "git"`: only Git-tracked files are
deployed, so ignored or untracked application state is not. The `.config/nvim`
directory remains a whole-directory symlink and `.config/starship.toml.tera`
is rendered as a template. `.apm` is also linked as a whole directory, so
its tracked `.gitignore` still excludes generated `apm_modules/` from Git
while those files remain accessible through the symlink.

If `~/.config/mise` already contains another checkout or regular files,
back it up and move it aside before adopting; mise does not replace unrelated
existing contents automatically.

Fast-forward the adopted repository and reapply bootstrap:

```sh
mise bootstrap --adopt itskyf/dotfiles --update
```

After editing sources under `.config` or `.var`, add new files to Git so
the Git manifest can deploy them. No custom `dotfiles.root`, `--from-dir`,
or `~/.dotfiles` checkout is needed.
