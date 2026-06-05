# detect_env.sh

readonly TAG=env

detect_env() {
  # --- ① CF判定（最優先） ---
  # LSF系 or ホスト名で判定
  if [[ -n "${LSB_JOBID:-}" ]] || [[ -n "${LSF_ENVDIR:-}" ]]; then
    log "$TAG" "LSB_JOBID or LSF_ENVDIR environment variable found"
    echo "CF"
    return
  fi

  if hostname | grep -qi "cf"; then
    log "$TAG" "hostname contains 'cf'"
    echo "CF"
    return
  fi

  # --- ② WSL判定 ---
  # Linuxっぽく見えるので明示的に分岐する必要あり
  if grep -qi microsoft /proc/version 2>/dev/null; then
    log "$TAG" "microsoft found in /proc/version"
    echo "WSL"
    return
  fi

  # unameでも補助判定
  if uname -r | grep -qi "microsoft"; then
    log "$TAG" "microsoft found in uname -r"
    echo "WSL"
    return
  fi

  # --- ③ Windows (Git Bash / MSYS / Cygwinなど) ---
  case "${OSTYPE:-}" in
    msys*|cygwin*|win32*)
      log "$TAG" "OSTYPE : ${OSTYPE}"
      echo "Windows"
      return
      ;;
  esac

  # --- ④ Linuxネイティブ ---
  if [[ "${OSTYPE:-}" == "linux-gnu"* ]]; then
    log "$TAG" "OSTYPE : ${OSTYPE}"
    echo "Linux"
    return
  fi

  # --- fallback ---
  echo "unknown"
}
