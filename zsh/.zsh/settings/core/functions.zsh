############################################################
# tmux用
############################################################
refresh_vscode_ipc() {
    local sock

    sock="$(ls -t /run/user/$UID/vscode-ipc-* 2>/dev/null | head -1)"

    if [[ -n "$sock" ]]; then
        export VSCODE_IPC_HOOK_CLI="$sock"

        if command -v tmux >/dev/null 2>&1 && [[ -n "$TMUX" ]]; then
            tmux setenv -g VSCODE_IPC_HOOK_CLI "$sock"
        fi
    fi
}

code () {
  refresh_vscode_ipc
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
    bsub verisium -debug -memlimit 32G -db "$1"
  }

  # vscode実行コマンド
  vscode() {
    bsub_int code --no-sandbox .
  }


  success "zshrc" "CF settings loaded"
fi
