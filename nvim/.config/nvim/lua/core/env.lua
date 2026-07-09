-- core/env.lua
-- detect_env.sh と同等の環境判定を Lua で実装
-- 戻り値: "CF" | "WSL" | "Windows" | "Linux" | "unknown"

local M = {}

local function detect()
  -- ① CF 判定（最優先）: LSF 環境変数 or ホスト名
  if vim.env.LSB_JOBID ~= nil or vim.env.LSF_ENVDIR ~= nil then
    return "CF"
  end

  local hostname = vim.fn.trim(vim.fn.system("hostname"))
  if hostname:lower():find("cf") then
    return "CF"
  end

  -- ② WSL 判定
  local proc_version = vim.fn.trim(vim.fn.system("cat /proc/version 2>/dev/null"))
  if proc_version:lower():find("microsoft") then
    return "WSL"
  end

  local uname_r = vim.fn.trim(vim.fn.system("uname -r 2>/dev/null"))
  if uname_r:lower():find("microsoft") then
    return "WSL"
  end

  -- ③ Windows (Git Bash / MSYS / Cygwin など)
  local ostype = vim.env.OSTYPE or ""
  if ostype:match("^msys") or ostype:match("^cygwin") or ostype:match("^win32") then
    return "Windows"
  end

  -- ④ Linux ネイティブ
  if ostype:match("^linux%-gnu") then
    return "Linux"
  end

  -- OSTYPE が未設定の場合は uname で補助判定
  local uname_s = vim.fn.trim(vim.fn.system("uname -s 2>/dev/null"))
  if uname_s == "Linux" then
    return "Linux"
  end

  return "unknown"
end

-- キャッシュして何度呼んでも 1 回だけ実行
M.name = detect()

-- 判定結果を確認しやすいヘルパー
M.is_cf      = M.name == "CF"
M.is_wsl     = M.name == "WSL"
M.is_windows = M.name == "Windows"
M.is_linux   = M.name == "Linux"

return M
