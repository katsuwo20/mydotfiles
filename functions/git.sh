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

}
