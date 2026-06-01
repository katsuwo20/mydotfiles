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

echo "=== Git Local setting ==="
LOCAL_GITCONFIG="$HOME/.gitconfig.local"
if [ ! -f "$LOCAL_GITCONFIG" ]; then
    read -p "Git user.name: " GIT_NAME
    read -p "Git user.email: " GIT_EMAIL
    cat <<EOF > "$LOCAL_GITCONFIG"
[user]
    name = $GIT_NAME
    email = $GIT_EMAIL
EOF
    echo "Created $LOCAL_GITCONFIG"
else
    echo "git local config already exists"
fi



echo "=== done ==="
echo "Restart WSL"
