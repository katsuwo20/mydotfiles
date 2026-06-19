-- ===============================
-- 基本設定
-- ===============================

local opt = vim.opt

-- --- 表示系 ---
opt.cursorline = true             -- 現在行を強調
opt.showmatch = true              -- 対応する括弧を表示
opt.laststatus = 2                -- ステータスライン常時表示
opt.list = true                   -- 不可視文字表示
opt.listchars = { tab = "▸ ", trail = "·", extends = "»", precedes = "«" }
opt.termguicolors = true          -- gui colorをオフにする
opt.number = true                 -- 行番号表示
vim.cmd("colorscheme tokyonight") -- tokyonightのからスキームを適用

-- --- 検索 ---
opt.ignorecase = true             -- 大文字小文字無視
opt.smartcase = true              -- 大文字を含む検索語では区別
opt.hlsearch = true               -- 検索ハイライト
opt.incsearch = true              -- インクリメンタル検索

-- --- 編集の基本 ---
opt.backspace = { "indent", "eol", "start" }
opt.autoindent = true
opt.smartindent = true
opt.hidden = true                 -- 未保存でも他バッファに移動可
opt.wrap = false                  -- デフォルトで折り返さない

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-- --- 文字コード/改行 ---
opt.encoding = "utf-8"
opt.fileencodings = { "utf-8", "cp932", "euc-jp", "iso-2022-jp", "default", "latin" }
opt.fileformats = { "unix", "dos", "mac" }

-- --- ファイル関連 ---
opt.backup = false
opt.swapfile = false
opt.autoread = true               -- 外部変更を自動再読込
opt.undofile = true               -- 永続 undo
opt.undodir = vim.fn.expand("~/.cache/nvim/undo")

-- --- コマンドライン/補完 ---
opt.wildmenu = true
opt.wildmode = "full"
opt.showcmd = true
