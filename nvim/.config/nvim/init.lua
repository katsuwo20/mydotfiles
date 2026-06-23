-- ===============================
-- init.lua - エントリポイント
-- lua/ 以下の設定ファイルを読み込む
-- ===============================

-- --- 基本設定 ---
require("core.options")

-- --- キーマップ ---
require("core.keymaps")

-- --- クリップボード ---
require("core.clipboard")

-- --- レジスタ制御 ---
require("core.register")

-- -- LSP設定
require("lsp")

-- --- プラグイン設定 ---
require("plugins.commentary")
require("plugins.current_word")
require("plugins.easymotion")
require("plugins.surround")
require("plugins.treesitter")
require("plugins.autopairs")
require("plugins.devicons")
require("plugins.neo-tree")
require("plugins.bufferline")
require("plugins.telescope")
require("plugins.toggleterm")
require("plugins.mason")
