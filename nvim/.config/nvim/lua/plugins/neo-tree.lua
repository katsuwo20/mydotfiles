-- ===============================
-- neo-tree 設定 (VSCode風)
-- ===============================

-- netrw は Neo-tree と役割が重なるため無効化
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- グローバルキーマップ（<C-b> / <leader>e / <leader>w / <leader>r）は
-- core/keymaps.lua に集約。

-- ##########################################
-- ツリー更新系
-- ##########################################
-- lazygit終了時
vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*lazygit*",
  callback = function()
    require("neo-tree.sources.filesystem.commands").refresh(
      require("neo-tree.sources.manager").get_state("filesystem")
    )
  end,
})


-- Nerd Font がない環境では `:let g:have_nerd_font = v:false` を設定すると
-- 下のフォールバック記号へ切り替わる。
local have_nerd_font = vim.g.have_nerd_font ~= false
local tree_width_step = 4
local tree_width_min = 20

local function resize_tree_width(state, delta)
	if not (state and state.winid and vim.api.nvim_win_is_valid(state.winid)) then
		return
	end

	local current_width = vim.api.nvim_win_get_width(state.winid)
	local max_width = math.max(tree_width_min, vim.o.columns - 20)
	local next_width = math.min(max_width, math.max(tree_width_min, current_width + delta))

	vim.api.nvim_win_set_width(state.winid, next_width)
	if state.window then
		state.window.width = next_width
	end
end

local function apply_neotree_ignored_highlight()
	vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#6b7280", italic = true })
end

apply_neotree_ignored_highlight()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = apply_neotree_ignored_highlight,
})

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
			-- Neo-tree上では Ctrl-h/l でペイン幅を調整
			["<C-h>"] = function(state)
				resize_tree_width(state, -tree_width_step)
			end,
			["<C-l>"] = function(state)
				resize_tree_width(state, tree_width_step)
			end,
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
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_ignored = false,
			hide_hidden = false,
			hide_by_name = {},
			never_show = {},
		},
	},

	-- 最後のウィンドウがツリーだけなら自動で閉じる
	close_if_last_window = true,
})
