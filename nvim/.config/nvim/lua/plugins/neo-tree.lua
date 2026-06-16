-- ===============================
-- neo-tree 設定 (VSCode風)
-- ===============================

-- netrw は Neo-tree と役割が重なるため無効化
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- VSCode風: Ctrl+b でサイドバーをトグル
vim.keymap.set("n", "<C-b>", ":Neotree toggle left<CR>", {
	noremap = true,
	silent = true,
	desc = "Neo-tree: toggle left sidebar",
})

-- VSCode風: 現在編集中ファイルをツリー上で追跡してフォーカス
vim.keymap.set("n", "<leader>e", ":Neotree reveal left<CR>", {
	noremap = true,
	silent = true,
	desc = "Neo-tree: reveal current file",
})

-- Nerd Font がない環境では `:let g:have_nerd_font = v:false` を設定すると
-- 下のフォールバック記号へ切り替わる。
local have_nerd_font = vim.g.have_nerd_font ~= false

require("neo-tree").setup({
	-- diagnostics / git 状態の描画で利用
	enable_diagnostics = true,
	enable_git_status = true,

	-- 他のペインを圧迫しにくい、VSCodeに近い固定寄りの横幅
	default_component_configs = {
		icon = {
			folder_closed = have_nerd_font and "" or "[+]",
			folder_open = have_nerd_font and "" or "[-]",
			folder_empty = have_nerd_font and "" or "[ ]",
			default = have_nerd_font and "" or "*",
		},
		indent = {
			with_expanders = true,
			expander_collapsed = have_nerd_font and "" or ">",
			expander_expanded = have_nerd_font and "" or "v",
		},
		name = {
			use_git_status_colors = true,
		},
		git_status = {
			symbols = {
				added = "+",
				modified = "~",
				deleted = "-",
				renamed = "R",
				untracked = "U",
				ignored = "I",
				unstaged = "!",
				staged = "S",
				conflict = "C",
			},
		},
	},

	-- VSCodeっぽく左ペイン固定運用
	window = {
		position = "left",
		width = 36,
		mappings = {
			-- Enterで開く
			["<CR>"] = "open",
			-- l/h で展開/折りたたみ (NerdTree系操作に近い)
			["l"] = "open",
			["h"] = "close_node",
			-- a/r/d は VSCode Explorer の新規/リネーム/削除に対応
			["a"] = "add",
			["r"] = "rename",
			["d"] = "delete",
			-- y/x/p でコピー/カット/ペースト
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			-- q で閉じる
			["q"] = "close_window",
		},
	},

	filesystem = {
		-- バッファ移動時にツリー追従 (VSCodeのExplorerに近い体験)
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
		-- 任意の場所からでも cwd をツリー側に寄せる
		bind_to_cwd = true,
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_by_name = {
				"node_modules",
				".git",
			},
		},
	},

	-- 最後のウィンドウがツリーだけなら自動で閉じる
	close_if_last_window = true,
})
