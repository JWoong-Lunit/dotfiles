#!/usr/bin/env bash
# Symlink dotfiles into ~
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

files=(.bashrc .bash_aliases .bash_functions .inputrc .gitconfig .tmux.conf)

for f in "${files[@]}"; do
    src="$DOTFILES_DIR/$f"
    dst="$HOME/$f"
    if [ ! -e "$src" ]; then
        echo "Skipping $f (not in repo)"
        continue
    fi
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "Backing up $dst → $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sf "$src" "$dst"
    echo "Linked $dst → $src"
done

echo "Done. Open a new shell to apply changes."
