# dotfiles

Personal shell, Git, and tmux configuration. Installed by symlinking each file into `$HOME`.

## Contents

| File | Purpose |
|------|---------|
| [`.bashrc`](.bashrc) | Bash base config — history, prompt, colors, completion, mise activation |
| [`.bash_aliases`](.bash_aliases) | Listing / navigation / GPU aliases |
| [`.bash_functions`](.bash_functions) | Directory bookmarks (`mark`/`jump`) and utilities |
| [`.inputrc`](.inputrc) | Readline — prefix history search, case-insensitive completion |
| [`.gitconfig`](.gitconfig) | Git identity, sane defaults, and aliases |
| [`.tmux.conf`](.tmux.conf) | tmux — truecolor, vi copy-mode, splits, status bar |
| [`install.sh`](install.sh) | Symlinks the above into `$HOME` |

## Install

```bash
git clone https://github.com/JWoong-Lunit/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

`install.sh` symlinks each tracked file into `$HOME`. If a real (non-symlink) file already exists at the destination, it's moved to `<file>.bak` first. Re-running is safe and idempotent — it just refreshes the links. Open a new shell afterward to apply changes.

To pick up changes later, `git pull` in `~/dotfiles`; the symlinks mean edits are live immediately (re-run `install.sh` only if files were added or removed).

## Bash

### History
- Duplicates and space-prefixed commands are ignored (`HISTCONTROL=ignoreboth`).
- 10k in-memory / 20k on-disk entries, timestamped.
- `history -a` runs on every prompt so parallel shells append rather than clobber each other's history.

### Shell options
- `globstar` — `**` matches recursively (`ls **/*.py`).
- `cdspell` — autocorrects minor typos in `cd` paths.
- `autocd` — type a directory name to `cd` into it.

### Prompt

### Completion & tools
- Loads system `bash-completion` if present (git, docker, etc.).
- Activates [mise](https://mise.jdx.dev/) for runtime/version management if `mise` is on `PATH`.

### Aliases (`.bash_aliases`)

| Alias | Expands to | Notes |
|-------|-----------|-------|
| `ll` | `ls -alF` | long listing, all files |
| `la` | `ls -A` | almost-all |
| `l` | `ls -CF` | columns |
| `..` / `...` | `cd ..` / `cd ../..` | up one / two levels |
| `cdo` | `cd ~/projects/oncology` | jump to the oncology project |
| `gpu` | `nvidia-smi` | GPU status |
| `gpuw` | `watch -n 0.5 nvidia-smi` | live GPU monitor |

### Functions (`.bash_functions`)

**Directory bookmarks** — stored as files under `~/.marks`:

| Command | Action |
|---------|--------|
| `mark <name>` | bookmark the current directory |
| `jump <name>` | `cd` to a bookmark (tab-completes names) |
| `marks` | list all bookmarks |
| `unmark <name>` | delete a bookmark (tab-completes names) |

**Utilities:**

| Command | Action |
|---------|--------|
| `ducks [dir]` | top 20 largest items under `dir` (default: cwd), sorted by size |

## Readline (`.inputrc`)

- ↑ / ↓ search history by the prefix already typed.
- Case-insensitive completion; ambiguous completions list immediately.

## Git (`.gitconfig`)

Notable defaults:
- `pull.rebase = true`, `rebase.autoStash` / `autoSquash` / `updateRefs` — clean, linear history that keeps stacked branches in sync.
- `push.autoSetupRemote` — `git push` works on brand-new branches with no `--set-upstream`.
- `fetch.prune` / `pruneTags` — deleted remote branches and tags disappear locally on fetch.
- `merge.conflictStyle = zdiff3` — conflict markers include the common ancestor.
- `diff.algorithm = histogram`, `colorMoved`, `mnemonicPrefix` — clearer diffs.
- `rerere.enabled` — remembers and replays past conflict resolutions.
- `commit.verbose` — shows the full diff in the commit-message editor.

### Aliases

| Alias | Command |
|-------|---------|
| `git st` | `status -sb` |
| `git co` / `sw` / `br` | `checkout` / `switch` / `branch` |
| `git ci` / `cm "msg"` | `commit` / `commit -m` |
| `git amend` | `commit --amend --no-edit` |
| `git unstage <path>` | `restore --staged` |
| `git last` | `log -1 HEAD --stat` |
| `git lg` | graph log, one line per commit |
| `git ls` | `log --oneline -20` |
| `git wt` / `wtl` / `wta` / `wtr` | `worktree` / `list` / `add` / `remove` |
| `git aliases` | list all aliases |
| `git root` | print repo top-level path |
| `git undo` | soft-reset the last commit (keep changes staged) |
| `git wip` | stage everything and commit `wip` (no hooks) |

## tmux (`.tmux.conf`)

- **Prefix:** `C-b` (default) **or** `C-a` (secondary, friendlier over SSH).
- **Reload config:** `prefix r`.
- **Splits:** `prefix |` (horizontal) / `prefix -` (vertical) — both keep the current directory; `prefix c` opens a new window in the current directory.
- **Pane navigation:** `prefix h/j/k/l` (vim-style); resize with `prefix H/J/K/L` (repeatable).
- **Copy mode:** vi keys — `v` begins selection, `y` copies, `Escape` cancels.
- Mouse on, 50k-line scrollback, windows/panes numbered from 1 and renumbered on close, truecolor passthrough.

## Secrets

`.bashrc` sources `~/.bashrc.secrets` if present — credentials that are **never committed** (it's in [`.gitignore`](.gitignore)).

```bash
# ~/.bashrc.secrets
export AZURE_CLIENT_ID=...
export AZURE_CLIENT_SECRET=...
export AZURE_TENANT_ID=...
```