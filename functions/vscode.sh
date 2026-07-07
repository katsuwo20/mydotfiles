# VS Code設定の同期を行うファイル

readonly TAG_vscode="vscode"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
VSCODE_DIR="$DOTFILES_DIR/vscode"

get_windows_appdata_dir() {
    local win_user

    if ! command -v cmd.exe >/dev/null 2>&1; then
        return 1
    fi

    win_user="$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')"
    if [[ -z "$win_user" ]]; then
        return 1
    fi

    printf '/mnt/c/Users/%s/AppData/\n' "$win_user"
}
get_windows_code_settings_dir() {
    printf '%sRoaming/Code/User\n' "$(get_windows_appdata_dir)"
}

WINDOWS_CODE_SETTING_DIR="$(get_windows_code_settings_dir)" || {
        warn "$TAG_vscode" "Could not determine Windows VS Code User directory. Skipping sync."
        return
    }

# dotfiles側のVS Code設定をWindows側User設定へ同期する関数
setup_vscode_user_files() {
    local source_dir
    local timestamp
    local latest_dir

    source_dir="$VSCODE_DIR/Machine"
    latest_dir="$VSCODE_DIR/latest/windows"

    log "$TAG_vscode" "Creating backup directory: $latest_dir"
    mkdir -p "$latest_dir"

    mkdir -p "$source_dir"
    mkdir -p "$WINDOWS_CODE_SETTING_DIR"
    timestamp="$(date +%Y%m%d%H%M%S)"

    for file in settings.json keybindings.json; do
        local src="$source_dir/$file"
        local dst="$WINDOWS_CODE_SETTING_DIR/$file"
        local latest_backup="$latest_dir/$file"
        local backup

        # dotfiles側が空でWindows側に既存があるなら取り込む
        if [[ ! -f "$src" && -f "$dst" ]]; then
            cp "$dst" "$src"
            success "$TAG_vscode" "Imported existing Windows $file into dotfiles."
        fi

        # どちらにもない場合は最小テンプレートを生成
        if [[ ! -f "$src" ]]; then
            if [[ "$file" == "settings.json" ]]; then
                printf '{}\n' > "$src"
            else
                printf '[]\n' > "$src"
            fi
            log "$TAG_vscode" "Created default $src"
        fi

        # 壊れたリンク/ジャンクションを通常ファイルに戻す
        if [[ -L "$dst" ]]; then
            rm -f "$dst"
        elif [[ -e "$dst" && ! -f "$dst" ]]; then
            backup="$dst.bak.$timestamp"
            mv "$dst" "$backup" 2>/dev/null || true
            log "$TAG_vscode" "Moved non-regular $file to $backup"
        fi

        log "$TAG_vscode" "Creating backup directory: $latest_dir"
        cp "$dst" "$latest_backup" 2>/dev/null || true # バックアップを作成
        cp "$src" "$dst" # dotfiles側の設定をWindows側にコピー
        success "$TAG_vscode" "Synced $file to Windows VS Code user settings."
    done

    log "$TAG_vscode" "Use sync_vscode_user_files_from_windows to import edits made in VS Code UI."
}

# Windows側のVS Code設定をdotfilesに取り込む関数
sync_vscode_user_files_from_windows() {
    local source_dir
    local latest_dir

    latest_dir="$VSCODE_DIR/latest/wsl"
    source_dir="$VSCODE_DIR/Machine"

    # 現在の設定ファイルをバックアップするためのディレクトリを作成
    log "$TAG_vscode" "Creating backup directory: $latest_dir"
    mkdir -p "$latest_dir"

    mkdir -p "$source_dir"

    for file in settings.json keybindings.json; do
        local src="$WINDOWS_CODE_SETTING_DIR/$file"
        local dst="$source_dir/$file"
        local latest_backup="$latest_dir/$file"

        if [[ -f "$src" ]]; then
            cp "$dst" "$latest_backup" 2>/dev/null || true # バックアップを作成
            cp "$src" "$dst" # Windows側の設定をdotfilesに取り込む
            success "$TAG_vscode" "Imported $file from Windows VS Code user settings."
        else
            warn "$TAG_vscode" "$src not found."
        fi
    done
}


create_vscode_symlink() {
    local vscode_data_dir
    local vscode_machine_dir
    local machine_dir
    vscode_machine_dir="$HOME/.vscode-server/data/Machine"

    log "$TAG_vscode" "Creating symlinks ..."
    mkdir -p "$vscode_machine_dir"
    rm -rf "$vscode_machine_dir/*"
    cd "$VSCODE_DIR"
    stow -v -t "$vscode_machine_dir" Machine
    success "$TAG_vscode" "Symlinks created successfully"
}


apply_vscode_backup() {
    log "$TAG_vscode" "Applying backup from $VSCODE_DIR/latest/windows to $WINDOWS_CODE_SETTING_DIR ..."
    for file in settings.json keybindings.json; do
        local backup="$VSCODE_DIR/latest/windows/$file"
        local dst="$WINDOWS_CODE_SETTING_DIR/$file"

        if [[ -f "$backup" ]]; then
            cp "$backup" "$dst"
            success "$TAG_vscode" "Restored $file from backup."
        else
            warn "$TAG_vscode" "Backup for $file not found at $backup."
        fi
    done
}

backup_vscode_extensions() {
    local extensions_dir
    local extensions_file_wsl
    local extensions_file_windows
    extensions_dir="$VSCODE_DIR/extensions"
    extensions_file_wsl="$extensions_dir/extensions_wsl.txt"
    extensions_file_windows="$extensions_dir/extensions_windows.txt"

    log "$TAG_vscode" "Backing up VSCode extensions to $extensions_file_wsl ..."

    mkdir -p "$extensions_dir"

    if code --list-extensions | grep '^[A-Za-z0-9_-]\+\.[A-Za-z0-9_.-]\+$' | sort > "$extensions_file_wsl"; then
        success "$TAG_vscode" "WSL extensions backed up successfully."
    else
        error "$TAG_vscode" "Failed to backup WSL extensions."
        return 1
    fi

    if cmd.exe /c "code --list-extensions" 2>/dev/null | tr -d '\r' | sort > "$extensions_file_windows"; then
        success "$TAG_vscode" "Windows extensions backed up successfully."
    else
        error "$TAG_vscode" "Failed to backup Windows extensions."
        return 1
    fi
}
