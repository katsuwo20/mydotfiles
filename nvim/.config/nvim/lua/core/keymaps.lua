-- ===============================
-- キーマップ設定（全プラグイン分をここに集約）
-- ===============================

vim.g.mapleader = " "

local map = vim.keymap.set

-- ===============================
-- 基本操作
-- ===============================

-- --- 移動系（通常モード） ---
map("n", "K", "10k", { desc = "10行上へ移動" })
map("n", "J", "10j", { desc = "10行下へ移動" })
map("n", "H", "0", { desc = "行頭へ移動" })
map("n", "L", "$", { desc = "行末へ移動" })

-- --- 移動系（ビジュアルモード） ---
map("v", "K", "10k", { desc = "10行上へ移動" })
map("v", "J", "10j", { desc = "10行下へ移動" })
map("v", "H", "0", { desc = "行頭へ移動" })
map("v", "L", "$", { desc = "行末へ移動" })

-- --- 矩形選択 ---
map("n", "<leader>V", "<C-v>", { desc = "矩形（ビジュアルブロック）選択" })

-- --- インサートモード脱出 ---
map("i", "jj", "<ESC>", { desc = "インサートモードを抜ける" })

-- --- d$ / d0 のショートカット ---
map("n", "dl", "d$", { desc = "カーソルから行末まで削除" })
map("n", "dh", "d0", { desc = "カーソルから行頭まで削除" })

-- --- 検索ハイライト解除 ---
map("n", "<Esc><Esc>", ":nohlsearch<CR>", { desc = "検索ハイライト解除" })

-- ===============================
-- コメント（vim-commentary）
-- ===============================
map("n", "<Leader>/", "gcc", { remap = true, desc = "コメントをトグル" })
map("x", "<Leader>/", "gc", { remap = true, desc = "コメントをトグル（選択範囲）" })

-- ===============================
-- サラウンド（vim-surround）
-- ===============================
-- ビジュアルモードで s で囲む（デフォルトの S に加えて）
map("x", "s", "<Plug>VSurround", { desc = "選択範囲を囲む" })

-- ===============================
-- カレントワード（vim-current-word）
-- ===============================
map("n", "<Leader>tw", ":VimCurrentWordToggle<CR>", { desc = "カレントワードのハイライトをトグル" })

-- ===============================
-- EasyMotion
-- ===============================
map("n", "<Leader>s", "<Plug>(easymotion-s)", { desc = "EasyMotion: 双方向1文字ジャンプ" })
-- 2文字検索（s の2文字版）
map("n", "<Leader>S", "<Plug>(easymotion-s2)", { desc = "EasyMotion: 双方向2文字ジャンプ" })

-- ===============================
-- Neo-tree（ファイルツリー）
-- ===============================
-- VSCode風: Ctrl+b でサイドバーをトグル
map("n", "<C-b>", ":Neotree toggle left<CR>", { noremap = true, silent = true, desc = "Neo-tree: サイドバーをトグル" })
-- VSCode風: 現在編集中ファイルをツリー上で追跡してフォーカス
map("n", "<leader>e", ":Neotree reveal left<CR>", { noremap = true, silent = true, desc = "Neo-tree: 現在ファイルを表示" })
-- Neo-tree から編集ウィンドウへフォーカスを戻す
map("n", "<leader>w", "<C-w>p", { noremap = true, silent = true, desc = "直前の編集ウィンドウへフォーカス" })
-- ツリーを手動更新
map("n", "<leader>r", function()
	require("neo-tree.sources.filesystem.commands").refresh(
		require("neo-tree.sources.manager").get_state("filesystem")
	)
end, { desc = "Neo-tree: ツリーを更新" })

-- ===============================
-- Bufferline（バッファ操作）
-- ===============================
-- バッファ移動
map("n", "<leader>.", ":BufferLineCycleNext<CR>", { silent = true, desc = "次のバッファへ" })
map("n", "<leader>,", ":BufferLineCyclePrev<CR>", { silent = true, desc = "前のバッファへ" })
-- バッファ並び替え
map("n", "<leader>>", ":BufferLineMoveNext<CR>", { silent = true, desc = "バッファを右へ移動" })
map("n", "<leader><", ":BufferLineMovePrev<CR>", { silent = true, desc = "バッファを左へ移動" })
-- 現在表示中のバッファを閉じる
map("n", "<leader>c", function()
	require("plugins.bufferline").close_current_buffer()
end, { silent = true, desc = "現在のバッファを閉じる" })
-- VSCode風: Ctrl+s で保存のみ (バッファは閉じない)
map("n", "<C-s>", ":update<CR>", { silent = true, desc = "現在のバッファを保存" })
map("i", "<C-s>", "<C-o>:update<CR>", { silent = true, desc = "現在のバッファを保存" })

-- ===============================
-- Telescope（検索）
-- ===============================
map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Telescope: ファイル検索" })
map("n", "<leader>fg", function()
	require("plugins.telescope").live_grep()
end, { desc = "Telescope: ライブグレップ" })
map("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Telescope: バッファ一覧" })
map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, { desc = "Telescope: ヘルプ検索" })

-- ===============================
-- ToggleTerm / ターミナル
-- ===============================
local term_opts = { noremap = true, silent = true }
-- 1番terminal固定
map("n", "<C-t>", "<cmd>1ToggleTerm<CR>", vim.tbl_extend("force", term_opts, { desc = "ターミナルをトグル" }))
map("t", "<C-t>", [[<C-\><C-n><cmd>1ToggleTerm<CR>]], vim.tbl_extend("force", term_opts, { desc = "ターミナルをトグル" }))
-- terminal → normal
map("t", "<Esc><Esc>", [[<C-\><C-n>]], vim.tbl_extend("force", term_opts, { desc = "ターミナルをノーマルモードへ" }))
-- lazygit（float）
map("n", "<leader>lg", function()
	require("plugins.toggleterm").lazygit_toggle()
end, vim.tbl_extend("force", term_opts, { desc = "LazyGit を開く" }))

-- ===============================
-- LSP（LspAttach 時のバッファローカル）
-- ===============================
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: 定義へジャンプ" }))
		map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: 参照一覧" }))
		map("n", "gk", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: ホバー表示" }))
		map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: リネーム" }))
	end,
})
