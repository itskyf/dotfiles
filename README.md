# Dotfiles

Source-controlled workstation setup with [mise](https://mise.jdx.dev/).

## Initialize

Install mise and Git, and authenticate with GitHub for private repositories.
Review any existing `~/.config/mise` and conflicting dotfiles before adoption.

```sh
mise bootstrap --adopt itskyf/dotfiles
```

The Git checkout lives at `~/.config/mise`; dotfile sources live in `home/`.

## Manage dotfiles

```sh
mise dot add ~/.config/example/config         # Capture a new file into home/
mise dot edit ~/.config/example/config        # Edit its source
mise dot edit --apply ~/.config/starship.toml  # Edit and render a template
mise dot status
mise dot apply
```

To stop deploying a group-managed file, delete its source and prune its symlink:

```sh
git -C ~/.config/mise rm home/.config/example/config
mise dot apply --prune
```

For a whole-directory link such as `~/.apm` or `~/.config/nvim`, run
`mise dot unapply <directory>` **before** removing its group entry and source.

Review and commit source changes:

```sh
git -C ~/.config/mise status --short
git -C ~/.config/mise add -A
git -C ~/.config/mise diff --cached
git -C ~/.config/mise commit -m "Update dotfiles"
```

Update and prune obsolete group-managed links on other machines:

```sh
mise bootstrap --adopt itskyf/dotfiles --update --prune-dotfiles
```

## Why this design?

`--adopt` makes this Git repository the global mise configuration, available
from any directory; `.mise/` isolates repository-only lint/format tools.
A single `home` group deploys new files without individual TOML entries and
remembers orphaned links for pruning. Git provides reviewable source history.

The group has **no Git manifest**, keeping `mise dot add` usable. Use that command
for source-controlled files, not `mise dot track` (mise's history-based tracking).
Keep generated files out of group-walked source directories: `.gitignore` alone
does not prevent mise from deploying them. APM and Neovim use whole-directory
symlinks; `home/.apm/.gitignore` ignores APM's `apm_modules/` in Git.
