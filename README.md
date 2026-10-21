# Dotfiles

Source-controlled workstation setup with [mise](https://mise.jdx.dev/).

## Setup

Install mise and review any existing `~/.config/mise` and conflicting dotfiles before adopting.
Authenticate GitHub before completing bootstrap to access the private repository:

```shell
mise bootstrap --adopt itskyf/dotfiles --only packages,dotfiles
MISE_EXEC_AUTO_INSTALL=false mise exec -- gh auth login --hostname github.com --git-protocol https --web
mise bootstrap
```

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
- **One group over per-file mappings:** New sources in `home/` deploy automatically with `symlink-each`; exceptions use explicit entries.
- **No Git manifest:** `mise dot add` can capture new group files and `mise dot apply --prune` removes orphaned links; `.gitignore` controls Git tracking, not deployment.
- **Isolated development tools:** `.mise/config.toml` and `.mise/mise.lock` are scoped to the repository rather than global tools.
