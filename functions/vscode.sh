# VS Code設定の同期を行うファイル

readonly TAG_vscode="vscode"

get_windows_code_user_dir() {
    local win_user

    if ! command -v cmd.exe >/dev/null 2>&1; then
        return 1
    fi

    win_user="$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')"
    if [[ -z "$win_user" ]]; then
        return 1
    fi

    printf '/mnt/c/Users/%s/AppData/Roaming/Code/User\n' "$win_user"
}

setup_vscode_user_files() {
    local base_dir
    local source_dir
    local windows_code_user_dir
    local timestamp

    base_dir="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
    source_dir="$base_dir/vscode/.config/Code/User"
    windows_code_user_dir="$(get_windows_code_user_dir)" || {
        warn "$TAG_vscode" "Could not determine Windows VS Code User directory. Skipping sync."
        return
    }

    mkdir -p "$source_dir"
    mkdir -p "$windows_code_user_dir"
    timestamp="$(date +%Y%m%d%H%M%S)"

    for file in settings.json keybindings.json; do
        local src="$source_dir/$file"
        local dst="$windows_code_user_dir/$file"
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

        cp "$src" "$dst"
        success "$TAG_vscode" "Synced $file to Windows VS Code user settings."
    done

    log "$TAG_vscode" "Use sync_vscode_user_files_from_windows to import edits made in VS Code UI."
}

sync_vscode_user_files_from_windows() {
    local base_dir
    local source_dir
    local windows_code_user_dir

    base_dir="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
    source_dir="$base_dir/vscode/.config/Code/User"
    windows_code_user_dir="$(get_windows_code_user_dir)" || {
        warn "$TAG_vscode" "Could not determine Windows VS Code User directory."
        return
    }

    mkdir -p "$source_dir"

    for file in settings.json keybindings.json; do
        local src="$windows_code_user_dir/$file"
        local dst="$source_dir/$file"

        if [[ -f "$src" ]]; then
            cp "$src" "$dst"
            success "$TAG_vscode" "Imported $file from Windows VS Code user settings."
        else
            warn "$TAG_vscode" "$src not found."
        fi
    done
}

create_vscode_symlink() {
    local base_dir
    base_dir="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

    log "$TAG_vscode" "Creating symlinks ..."
    cd "$base_dir"
    stow -v -t ~ vscode
    success "$TAG_vscode" "Symlinks created successfully"
}
