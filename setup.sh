#!/usr/bin/env bash

set -euo pipefail

readonly ENV_CF="CF"
readonly ENV_WSL="WSL"
readonly ENV_WINDOWS="Windows"
readonly ENV_LINUX="Linux"
readonly ENV_UNKNOWN="unknown"

# ファイルの場所を特定
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR
# 環境系の設定をsource
source "$DOTFILES_DIR/functions/env.sh"

# 共通関数の読み込み
source "$FUNCTIONS_DIR/utils.sh"
log "setup" "Loading function from $FUNCTIONS_DIR/parse_args.sh"
# 引数の解析
source "$FUNCTIONS_DIR/parse_args.sh" "$@"

# functionsディレクトリ内の関数の読み込み
for func in "$FUNCTIONS_DIR"/*.sh; do
    [[ "$func" == env.sh ]] && continue # env.shは既に読み込んでいるのでスキップ
    [[ "$func" == utils.sh ]] && continue # utils.shは既に読み込んでいるのでスキップ
    [[ "$func" == parse_args.sh ]] && continue # parse_args.shは既に読み込んでいるのでスキップ

    log "setup" "Loading function from $func"
    source "$func"
done

# 環境を判定
ENV=$(detect_env)
if [[ "$ENV" == "$ENV_UNKNOWN" ]]; then
    error "env" "Could not detect environment. Exiting."
    exit 1
else
    success "env" "Detected environment: $ENV"
fi

# 環境に応じて処理を変更
case "$ENV" in
    "$ENV_CF")
        # mydotfilesのシンボリックリンクをhomeディレクトリに作成
        linkup_home

        # CF環境向けのインストール処理を実行
        install_for_cf

        # zshの設定を行う
        setup_zsh_cf

        # tmuxの設定を行う
        setup_tmux_cf

        # vimの設定を行う
        setup_vim_cf
        setup_nvim_cf

        # zoxideの設定を行う
        setup_zoxide

        # fzfの設定を行う
        setup_fzf

        # ripgrepの設定を行う
        setup_ripgrep

        # fdの設定を行う
        setup_fd

        # lazygitの設定を行う
        setup_lazygit

        # .configの設定を行う
        setup_config_cf

        warn "env" "CF environment does not support this setup script."
        exit 0
        ;;
    "$ENV_WSL")
        log "env" "Running in WSL environment. Proceeding with setup."

        # mydotfilesのシンボリックリンクをhomeディレクトリに作成
        linkup_home

        # Linux環境向けのインストール処理を実行
        install_for_linux

        # zshの設定を行う
        setup_zsh
        unpack_win32yank

        # tmuxの設定を行う
        setup_tmux

        # vimの設定を行う
        setup_vim
        setup_nvim

        # zoxideの設定を行う
        setup_zoxide

        # uvの設定を行う
        setup_uv

        # gitの設定を行う
        setup_git

        # .configの設定
        setup_config

        # WSL上では、dotfiles側のVS Code設定をWindows側User設定へ同期
        setup_vscode_user_files
        create_vscode_symlink
        ;;
    "$ENV_WINDOWS")
        warn "env" "Windows environment does not support this setup script."
        exit 0
        ;;
    "$ENV_LINUX")
        warn "env" "Linux environment does not support this setup script."
        exit 0
        ;;
esac


# ====================================
# 終了処理
# ====================================
# 最後に元のディレクトリに戻る
cd "$DOTFILES_DIR"

success "setup" "Setup completed successfully"
