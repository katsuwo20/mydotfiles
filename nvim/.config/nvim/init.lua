-- ===============================
-- init.lua - エントリポイント
-- lua/ 以下の設定ファイルを読み込む
-- ===============================

-- --- 環境判定 ---
-- env.name: "CF" | "WSL" | "Linux" | "Windows" | "unknown"
-- env.is_cf / env.is_wsl / env.is_linux / env.is_windows
local env = require("core.env")
local is_vscode = vim.g.vscode ~= nil

-- --- 基本設定 ---
require("core.options")

-- --- クリップボード ---
require("core.clipboard")

-- --- レジスタ制御 ---
require("core.register")

-- --- キーマップ ---
require("core.keymaps")

-- --- プラグイン設定 ---
require("plugins.commentary")
require("plugins.easymotion")
require("plugins.surround")

-- VSCode側がUI・LSP・補完を担当するため、通常のNeovimでのみ読み込む
if not is_vscode then
    require("lsp")
    require("plugins.current_word")
    require("plugins.autopairs")
    require("plugins.devicons")
    require("plugins.neo-tree")
    require("plugins.bufferline")
    require("plugins.telescope")
    require("plugins.toggleterm")
    require("plugins.cmp")
    require("plugins.which-key")

    -- CF環境では以下のプラグインを読み込まない
    if not env.is_cf then
        require("plugins.copilot")
        require("plugins.treesitter")
        require("plugins.mason")
    end
end
--
-- 例: WSL のみ追加プラグインを読み込む
--   if env.is_wsl then
--     require("plugins.wsl_extra")
--   end
