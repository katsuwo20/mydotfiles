#!/usr/bin/env bash

set -e

echo "=== install packages ==="

sudo apt update
sudo apt install -y \
    locales \
    zsh \
    git \
    curl \
    fzf \
    stow

sudo locale-gen ja_JP.UTF-8
sudo update-locale LANG=ja_JP.UTF-8

echo "=== install dotfiles ==="

DOTFILES_DIR="$HOME/ghq/github.com/katsuwo20/mydotfiles"
cd "$DOTFILES_DIR"

echo "Applying zsh settings"
stow -v -t ~ zsh

echo "Applying git settings"
stow -v -t ~ git


echo "=== change defautl shell ==="


chsh -s $(which zsh)

echo "=== Git setting ==="
# user.name 確認
if ! git config --global user.name >/dev/null; then
    read -p "Git user.name: " GIT_NAME
    git config --global user.name "$GIT_NAME"
else
    echo "git user.name already set"
fi

# user.email 確認
if ! git config --global user.email >/dev/null; then
    read -p "Git user.email: " GIT_EMAIL
    git config --global user.email "$GIT_EMAIL"
else
    echo "git user.email already set"
fi


echo "=== done ==="
echo "Restart WSL"