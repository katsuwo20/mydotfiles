-- ===============================
-- vim-easymotion 設定
-- ===============================

-- --- おすすめ設定 ---
vim.g.EasyMotion_smartcase = 1         -- smartcase で検索
vim.g.EasyMotion_do_mapping = 0        -- デフォルトマッピング無効化（自前で定義）
vim.g.EasyMotion_enter_jump_first = 1  -- Enter で最初の候補にジャンプ
vim.g.EasyMotion_space_jump_first = 1  -- Space でも最初の候補にジャンプ
vim.g.EasyMotion_verbose = 0           -- VSCodeの出力チャネルへ動作メッセージを送らない
if vim.g.vscode then
	vim.g.EasyMotion_prompt = "" -- VSCodeの出力チャネルへ検索プロンプトを送らない
end

-- キーマップは core/keymaps.lua に集約。
