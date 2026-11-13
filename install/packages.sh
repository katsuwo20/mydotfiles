
#!/usr/bin/env bash

set -e

# 共通関数の読み込み
source "$FUNCTIONS_DIR/utils.sh"

log packages "Installing packages..."

sudo apt update
sudo apt upgrade -y || true
apt_packages=(
    locales
    zsh
    git
    git-lfs
    curl
    stow
    python3
    python3-venv
    python3-pip
    unzip
    ripgrep
    fd-find
    npm
    build-essential
    tree-sitter-cli
    libsecret-1-0
    clangd
)

# lua-language-server is not available in every Debian/Ubuntu repository.
if apt-cache show lua-language-server >/dev/null 2>&1; then
    apt_packages+=(lua-language-server)
else
    warn packages "lua-language-server is not available from apt; skipping it"
fi

sudo apt install -y "${apt_packages[@]}"

success packages "Packages installed successfully"

log packages "Cleaning up..."
sudo apt autoremove -y
