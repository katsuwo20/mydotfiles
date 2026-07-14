-- ===============================
-- init.lua - エントリポイント
-- lua/ 以下の設定ファイルを読み込む
-- ===============================

-- --- 環境判定 ---
-- env.name: "CF" | "WSL" | "Linux" | "Windows" | "unknown"
-- env.is_cf / env.is_wsl / env.is_linux / env.is_windows
local env = require("core.env")

-- --- 基本設定 ---
require("core.options")

-- --- クリップボード ---
require("core.clipboard")

-- --- レジスタ制御 ---
require("core.register")

-- --- キーマップ ---
require("core.keymaps")

-- -- LSP設定
require("lsp")

-- --- プラグイン設定 ---
require("plugins.commentary")
require("plugins.current_word")
require("plugins.easymotion")
require("plugins.surround")
require("plugins.autopairs")
require("plugins.devicons")
require("plugins.neo-tree")
require("plugins.bufferline")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.cmp")
require("plugins.which-key")

-- --- 環境依存のプラグイン設定 ---
-- CF環境では 以下のプラグインを読み込まないようにする
if not env.is_cf then
    require("plugins.copilot")
    require("plugins.treesitter")
    require("plugins.mason")
end
--
-- 例: WSL のみ追加プラグインを読み込む
--   if env.is_wsl then
--     require("plugins.wsl_extra")
--   end
