#!/usr/bin/env bash

set -e

echo "=== install packages ==="

sudo apt update
sudo apt install -y \
    zsh \
    git \
    curl \
    fzf \
    stow

echo "=== install dotfiles ==="

DOTFILES_DIR="$HOME/ghq/github.com/katsuwo20/mydotfiles"
cd "$DOTFILES_DIR"
stow -v -t ~ zsh

echo "=== change defautl shell ==="


chsh -s $(which zsh)

echo "=== done ==="
echo "Restart WSL"