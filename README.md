# Dotfiles

Source-controlled workstation setup with [mise](https://mise.jdx.dev/).

## Initialize

Install mise, Git, and Homebrew; ensure `brew` is on `PATH`. Review any
existing `~/.config/mise` and conflicting dotfiles first.

The dotfiles repository is public. Adopt it and install packages (including
`brew:gh`) and dotfiles before cloning private repositories:

```sh
mise bootstrap --adopt itskyf/dotfiles --only packages,dotfiles
command -v gh
gh auth login --hostname github.com --git-protocol https --web
mise token github
mise bootstrap
```

If `gh` is not on `PATH`, load Homebrew in your current shell first:
`eval "$(brew shellenv bash)"` (Bash) or `brew shellenv fish | source` (Fish).
There is no need for `mise exec gh` or exporting a token: mise's existing
`[settings.github] credential_command` reads the token from `gh`'s credential
store. Git credentials are already configured by the managed `~/.gitconfig`;
do not run `gh auth setup-git` or let login overwrite that configuration.

The checkout lives at `~/.config/mise`; deployable dotfile sources live in
`home/`. Global mise commands work from any directory.

## Manage dotfiles

```sh
mise dot add ~/.config/example/config         # Capture a new file into home/
mise dot edit ~/.config/example/config        # Edit its source
mise dot edit --apply ~/.config/starship.toml  # Edit and render a template
mise dot status
mise dot apply
```

To stop deploying a group-managed file, remove its source and prune its symlink:

```sh
cd ~/.config/mise
git rm home/.config/example/config
mise dot apply --prune
```

For a whole-directory link such as `~/.apm` or `~/.config/nvim`, run
`mise dot unapply <directory>` **before** removing its group entry and source.

Review source changes before committing:

```sh
cd ~/.config/mise
git status --short
git diff
git add --all
git diff --cached
git commit --message "Update dotfiles"
```

Update the checkout and prune obsolete group-managed links on other machines:

```sh
mise bootstrap --adopt itskyf/dotfiles --update --prune-dotfiles
```

## Why this design?

- **`--adopt` over `--from`:** Adopt makes this Git checkout mise's global
  config, loaded from any directory. From runs a bootstrap project from a
  separate checkout; it does not install that project's config globally.
- **Source-controlled over history-based adoption / `mise dot track`:**
  Regular Git commits and PRs are the source of truth, not mise's file history.
  Use `mise dot add` to capture a new managed source.
- **`home/` plus `.mise/`:** Dotfiles are isolated from repository tooling.
  The project-only lint/format tools and lockfile stay in `.mise/`.
- **One group over individual `[dotfiles]` entries:** New sources deploy
  without per-file declarations, and `--prune` removes orphaned group links.
- **`symlink-each` over linking all of `~`:** Real target directories can
  coexist with unmanaged app files. APM and Neovim intentionally link entire
  directories; Starship renders a template.
- **No `manifest = "git"`:** Git-index manifests restrict deployment to
  tracked files but prevent `mise dot add` from capturing into the group.
  Keep generated files out of walked sources: `.gitignore` alone does not
  stop deployment. `home/.apm/.gitignore` excludes `apm_modules/` from Git.
