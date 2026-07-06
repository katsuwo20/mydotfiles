#!/usr/bin/env bash
set -e

# 共通関数の読み込み
source "$FUNCTIONS_DIR/utils.sh"

readonly TAG=nodejs
readonly NODE_MAJOR=22
readonly NODE_INSTALL_DIR="$HOME/.local/nodejs"

log "$TAG" "Setting up Node.js >= v${NODE_MAJOR}..."

# ~/.local/bin へのシンボリックリンクを作成するヘルパー
_link_node_bins() {
  mkdir -p "$HOME/.local/bin"
  for bin in node npm npx corepack; do
    if [[ -f "$NODE_INSTALL_DIR/bin/$bin" ]]; then
      ln -sf "$NODE_INSTALL_DIR/bin/$bin" "$HOME/.local/bin/$bin"
      log "$TAG" "Linked: $HOME/.local/bin/$bin"
    fi
  done
}

# 既にインストール済みの場合はリンクを張り直してバージョン確認
if [[ -d "$NODE_INSTALL_DIR/bin" ]]; then
  _link_node_bins
  current=$("$NODE_INSTALL_DIR/bin/node" --version | sed 's/v//' | cut -d. -f1)
  if [[ "$current" -ge "$NODE_MAJOR" ]]; then
    success "$TAG" "Node.js $("$NODE_INSTALL_DIR/bin/node" --version) already installed (>= v${NODE_MAJOR})"
    exit 0
  fi
  log "$TAG" "Installed version is too old (v${current}). Upgrading..."
fi

# 最新バージョンを取得
log "$TAG" "Fetching latest Node.js v${NODE_MAJOR}.x version..."
NODE_VERSION=$(curl -fsSL "https://nodejs.org/dist/latest-v${NODE_MAJOR}.x/SHASUMS256.txt" \
  | grep "linux-x64\.tar\.gz$" \
  | awk '{print $2}' \
  | sed 's/node-\(v[0-9]*\.[0-9]*\.[0-9]*\)-.*/\1/' \
  | head -1)

if [[ -z "$NODE_VERSION" ]]; then
  error "$TAG" "Failed to determine Node.js version"
  exit 1
fi

log "$TAG" "Downloading Node.js ${NODE_VERSION} (linux-x64)..."
ARCHIVE="node-${NODE_VERSION}-linux-x64.tar.gz"
curl -fsSL "https://nodejs.org/dist/${NODE_VERSION}/${ARCHIVE}" -o "/tmp/${ARCHIVE}"

log "$TAG" "Extracting to ${NODE_INSTALL_DIR}..."
rm -rf "$NODE_INSTALL_DIR"
mkdir -p "$NODE_INSTALL_DIR"
tar -xf "/tmp/${ARCHIVE}" --strip-components=1 -C "$NODE_INSTALL_DIR"
rm "/tmp/${ARCHIVE}"

_link_node_bins

success "$TAG" "Node.js ${NODE_VERSION} installed to ${NODE_INSTALL_DIR}"
