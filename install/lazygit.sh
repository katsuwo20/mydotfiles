
#!/usr/bin/env bash
set -e

# 共通関数の読み込み
source "$FUNCTIONS_DIR/utils.sh"

readonly TAG=lazygit

log "$TAG" "Installing lazygit..."

if command -v lazygit >/dev/null 2>&1; then
  log "$TAG" "lazygit already installed"
  exit 0
fi

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
  | grep -Po '"tag_name": "v\K[^"]*')

curl -Lo lazygit.tar.gz \
  "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin/

log "$TAG" "lazygit version $LAZYGIT_VERSION installed"
log "$TAG" "Cleaning up..."
rm lazygit lazygit.tar.gz

success "$TAG" "lazygit installed successfully"
