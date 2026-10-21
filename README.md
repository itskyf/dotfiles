# Dotfiles

Source-controlled workstation setup with [mise](https://mise.jdx.dev/).

## Setup

Install mise and review any existing `~/.config/mise` and conflicting dotfiles before adopting.
Mise can offer to install Git if missing; system packages such as `libatomic` may require elevated privileges.
The dotfiles repository is public, but `krinode` is private, so install packages and dotfiles, authenticate without auto-installing other global tools, then complete bootstrap:

```shell
mise bootstrap --adopt itskyf/dotfiles --only packages,dotfiles
MISE_EXEC_AUTO_INSTALL=false mise exec -- gh auth login --hostname github.com --git-protocol https --web
mise bootstrap
```

`MISE_EXEC_AUTO_INSTALL=false` applies only to the login command; the final `mise bootstrap` installs the remaining global tools and clones the private repository.
Mise installs `brew:` packages without requiring Homebrew, and the global `[env]` adds their executable directory to mise-managed environments.
The managed `~/.gitconfig` configures the GitHub credential helper, while `[settings.github]` reads `gh auth token`; no manual token export or `gh auth setup-git` is needed.
The checkout lives at `~/.config/mise`, its dotfile sources live in `home/`, and global mise commands work from any directory.

## Manage dotfiles

```shell
mise dot add ~/.config/example/config
mise dot edit ~/.config/example/config
mise dot edit --apply ~/.config/starship.toml
mise dot status
mise dot apply
```

To stop deploying a group-managed file, delete its source and prune its symlink:

```shell
cd ~/.config/mise
git rm home/.config/example/config
mise dot apply --prune
```

For whole-directory links such as `~/.apm` and `~/.config/nvim`, run `mise dot unapply <directory>` before removing the corresponding group entry and source.

Review changes before committing:

```shell
cd ~/.config/mise
git status --short
git diff
git add --all
git diff --cached
git commit --message "Update dotfiles"
```

## Update

```shell
mise bootstrap --adopt itskyf/dotfiles --update --prune-dotfiles
```

## Why this design?

- **`--adopt` over `--from`:** The Git checkout becomes the global mise configuration instead of remaining a separate bootstrap project.
- **Source-controlled over history-based:** Git commits and PRs remain the source of truth rather than `mise dot track`.
- **One group over per-file mappings:** `home/` deploys new sources with `symlink-each`, while APM and Neovim use whole-directory symlinks and Starship uses a template.
- **No Git manifest:** `mise dot add` can capture new group files and `mise dot apply --prune` removes orphaned links; `.gitignore` controls Git tracking, not deployment.
- **Isolated development tools:** `.mise/config.toml` and `.mise/mise.lock` are scoped to the repository rather than global tools.
