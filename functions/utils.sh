
#!/usr/bin/env bash

# 色定義
readonly COLOR_RESET="\033[0m"
readonly COLOR_BLUE="\033[1;34m"
readonly COLOR_YELLOW="\033[1;33m"
readonly COLOR_RED="\033[1;31m"
readonly COLOR_GREEN="\033[1;32m"

log() {
  local tag="$1"
  local message="$2"
  printf "${COLOR_BLUE}[%s]${COLOR_RESET} %s\n" "$tag" "$message" >&2
}

warn() {
  local tag="$1"
  local message="$2"
  printf "${COLOR_YELLOW}[%s] WARN:${COLOR_RESET} %s\n" "$tag" "$message" >&2
}

error() {
  local tag="$1"
  local message="$2"
  printf "${COLOR_RED}[%s] ERROR:${COLOR_RESET} %s\n" "$tag" "$message" >&2
}

success() {
  local tag="$1"
  local message="$2"
  printf "${COLOR_GREEN}[%s]${COLOR_RESET} %s\n" "$tag" "$message" >&2
}


unpack_common() {
    local pack_name="$1"
    local tag="$pack_name"
    local bin_name="$pack_name"
    local archive="${2:-$1}.tar.gz" #default =pack_name
    local extracted_dir

    log "$tag" "get archive name"
    cd "$PACKAGES_DIR" || return 1
    if [ ! -f "$archive" ]; then
      error "$tag" "archive not found: $PACKAGES_DIR/$archive"
      return 1
    fi

    # Avoid head -1 here: with pipefail, tar can fail by SIGPIPE and stop setup.
    extracted_dir=$(tar -tf "$archive" | cut -d/ -f1 | sed -n '1p')
    if [ -z "$extracted_dir" ]; then
      error "$tag" "failed to detect extracted directory from $archive"
      return 1
    fi

    log "$tag" "unpack the $archive"
    cd "$LOCAL_DIR" || return 1
    [ -n "$extracted_dir" ] && rm -rf "$extracted_dir"

    cd "$PACKAGES_DIR" || return 1
    log "$tag" "unpacking..."
    tar -xf "$archive" -C "$LOCAL_DIR" || return 1

    log "$tag" "add it to the PATH"

    mkdir -p "$LOCAL_BIN_DIR" || return 1
    cd "$LOCAL_BIN_DIR" || return 1

    rm -f "$bin_name"
    ln -s "$LOCAL_DIR/$extracted_dir/bin/$bin_name" "$bin_name"

    success "$tag" "$bin_name installed successfully"
}
