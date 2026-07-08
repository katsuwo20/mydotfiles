# ファイルの場所を特定
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/mydotfiles}"
# 環境系の設定をsource
source "$DOTFILES_DIR/functions/env.sh"
source "$DOTFILES_DIR/functions/utils.sh"


# 現在の環境を判定する関数を読み込む
source "$FUNCTIONS_DIR/detect_env.sh"
ENV=$(detect_env)
if [[ "$ENV" == "unknown" ]]; then
    error "env" "Could not detect environment. Exiting."
    exit 1
else
    success "env" "Detected environment: $ENV"
fi


############################################################
# tmux用
############################################################
code () {
    export VSCODE_IPC_HOOK_CLI="$(
        ls -t /run/user/$UID/vscode-ipc-* 2>/dev/null |
        head -1
    )"

    command code "$@"
}


############################################################
# CF用
############################################################
# CF用の設定を読み込む
if [[ "$ENV" == "CF" ]]; then
  log "zshrc" "source CF settings"

  # bsubコマンド関連
  bsub() {
    command bsub -Is -q re8bat_full "$@"
  }
  bsubn() {
    command bsub "$@"
  }
  bsub_int() {
    command bsub -Is -q re8int_full "$@"
  }
  verisium() {
    bsub_int verisium -debug -memlimit 16G -db "$1"
  }

  # vscode実行コマンド
  vscode() {
    bsub_int code --no-sandbox .
  }


  success "zshrc" "CF settings loaded"
fi
