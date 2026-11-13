# 2重書き込み防
[[ -n ${__GIT_LOADED:-} ]] && return
readonly __GIT_LOADED=1

setup_git() {
    cd "$DOTFILES_DIR"

    log "git" "Applying git settings ..."
    stow -v -t ~ git

    log "git" "Setting up Git local configuration ..."
    LOCAL_GITCONFIG="$HOME/.gitconfig.local"
    if [ ! -f "$LOCAL_GITCONFIG" ]; then
        read -p "Git user.name: " GIT_NAME
        read -p "Git user.email: " GIT_EMAIL
        cat <<EOF > "$LOCAL_GITCONFIG"
    [user]
        name = $GIT_NAME
        email = $GIT_EMAIL
EOF
        log "git" "Created $LOCAL_GITCONFIG"
    else
        log "git" "Git local configuration already exists at $LOCAL_GITCONFIG"
    fi

    log "git" "Setting up ghq ..."
    mkdir -p "$HOME/ghq"
    git config --file "$HOME/.gitconfig.local" --unset-all ghq.root 2>/dev/null || true
    git config --file "$HOME/.gitconfig.local" --add ghq.root "$HOME/ghq"
    log "git" "ghq root set to $HOME/ghq"

    log "git" "Setting up git safe.directory ..."
    git config --file "$HOME/.gitconfig.local" --unset-all safe.directory 2>/dev/null || true
    git config --file "$HOME/.gitconfig.local" --add safe.directory "$HOME/ghq/*"
    log "git" "safe.directory set to $HOME/ghq"

    setup_git_lfs
}

# git-lfs の導入と global filter 設定（未設定の場合のみ）
setup_git_lfs() {
    log "git-lfs" "Checking Git LFS ..."

    if ! git lfs version >/dev/null 2>&1; then
        if command -v apt >/dev/null 2>&1; then
            log "git-lfs" "git-lfs not found; installing via apt ..."
            sudo apt install -y git-lfs
        else
            warn "git-lfs" "git-lfs not found and apt is unavailable; skipping"
            return 0
        fi
    fi

    local key expected actual configured=true
    for key in clean smudge process required; do
        case "$key" in
            clean)    expected="git-lfs clean -- %f" ;;
            smudge)   expected="git-lfs smudge -- %f" ;;
            process)  expected="git-lfs filter-process" ;;
            required) expected="true" ;;
        esac
        actual=$(git config --global --get "filter.lfs.$key" || true)
        if [[ "$actual" != "$expected" ]]; then
            configured=false
            break
        fi
    done

    if [[ "$configured" == "true" ]]; then
        log "git-lfs" "Git LFS filter is already configured"
    else
        # --skip-repo: only write global filter settings, don't touch hooks of the current repo
        git lfs install --skip-repo
        success "git-lfs" "Git LFS initialized"
    fi

    log "git-lfs" "$(git lfs version)"
}
