-- ===============================
-- vim-current-word 設定
-- ===============================

-- ハイライトの有効/無効
vim.g["vim_current_word#enabled"] = 1

-- カーソル下の単語のハイライト色
vim.api.nvim_set_hl(0, "CurrentWord",      { bg = "#3a3a3a" })
vim.api.nvim_set_hl(0, "CurrentWordTwins", { bg = "#2a2a2a" })

-- 遅延時間（ms）- カーソル移動後にハイライトするまでの待機
vim.g["vim_current_word#delay_ms"] = 50

-- 特定のファイルタイプでは無効化
vim.g["vim_current_word#excluded_filetypes"] = { "NvimTree", "help", "qf" }

-- キーマップ: トグル
vim.keymap.set("n", "<Leader>tw", ":VimCurrentWordToggle<CR>")
