# dotfiles

Personal shell configuration.

## Files

| File | Purpose |
|------|---------|
| `.bashrc` | Bash base config |
| `.bashrc.local` | Prompt, aliases, bookmark functions, mise activation |
| `.zshrc` | Zsh config (delegates to mise) |
| `.gitconfig` | Git identity |

## Install

```bash
git clone https://github.com/JWoong-Lunit/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

## Secrets

Machine-local secrets (e.g. Azure credentials) go in `~/.bashrc.secrets`, which is sourced by `.bashrc.local` but never committed.

```bash
# ~/.bashrc.secrets
export AZURE_CLIENT_ID=...
export AZURE_CLIENT_SECRET=...
export AZURE_TENANT_ID=...
```
