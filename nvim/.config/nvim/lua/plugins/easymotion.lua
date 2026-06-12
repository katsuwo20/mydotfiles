-- ===============================
-- vim-easymotion 設定
-- ===============================

local map = vim.keymap.set

-- --- おすすめ設定 ---
vim.g.EasyMotion_smartcase = 1         -- smartcase で検索
vim.g.EasyMotion_do_mapping = 0        -- デフォルトマッピング無効化（自前で定義）
vim.g.EasyMotion_enter_jump_first = 1  -- Enter で最初の候補にジャンプ
vim.g.EasyMotion_space_jump_first = 1  -- Space でも最初の候補にジャンプ

-- --- 基本キーマップ ---
map("n", "<Leader>w", "<Plug>(easymotion-w)")
map("n", "<Leader>f", "<Plug>(easymotion-f)")
map("n", "<Leader>s", "<Plug>(easymotion-s)")

-- 2文字検索（s の2文字版）
map("n", "<Leader>S", "<Plug>(easymotion-s2)")

-- 行内移動
map("n", "<Leader>l", "<Plug>(easymotion-lineforward)")
map("n", "<Leader>h", "<Plug>(easymotion-linebackward)")

-- 行ジャンプ
map("n", "<Leader>j", "<Plug>(easymotion-j)")
map("n", "<Leader>k", "<Plug>(easymotion-k)")
