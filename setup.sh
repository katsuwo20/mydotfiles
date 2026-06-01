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

echo "=== set locale ==="
sudo locale-gen ja_JP.UTF-8
sudo update-locale LANG=ja_JP.UTF-8


DOTFILES_DIR="$HOME/ghq/github.com/katsuwo20/mydotfiles"
cd "$DOTFILES_DIR"

echo " === zsh settings ==="
echo "Applying zsh settings"
stow -v -t ~ zsh

echo "=== change default shell ==="
chsh -s $(which zsh)


echo "Applying git settings"
stow -v -t ~ git

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

echo "=== setup ghq ==="
mkdir -p "$HOME/ghq"
git config --file "$HOME/.gitconfig.local" --unset-all ghq.root 2>/dev/null || true
git config --file "$HOME/.gitconfig.local" --add ghq.root "$HOME/ghq"
echo "ghq root set to $HOME/ghq"

echo "=== setup git safe.directory === "
git config --file "$HOME/.gitconfig.local" --unset-all safe.directory 2>/dev/null || true
git config --file "$HOME/.gitconfig.local" --add safe.directory "$HOME/ghq/*"
echo "safe.directory set to $HOME/ghq"


echo "=== done ==="
echo "Restart WSL"
