require("nvim-autopairs").setup({
	check_ts = true,
	-- String/comment node上では自動ペアを抑止
	ts_config = {
		lua = { "string", "comment" },
		javascript = { "string", "template_string", "comment" },
		typescript = { "string", "template_string", "comment" },
		jsx = { "string", "comment" },
		tsx = { "string", "comment" },
		python = { "string", "comment" },
		go = { "string", "comment" },
		rust = { "string", "comment" },
	},

	-- VSCode寄せ: Enter時のペア改行は維持、Backspaceペア削除は無効
	map_cr = true,
	map_bs = false,
	map_c_h = false,
	map_c_w = false,

	-- 実運用での誤爆を減らす
	disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input", "vim" },
	disable_in_macro = true,
	disable_in_replace_mode = true,
	enable_check_bracket_line = true,
	break_undo = true,
})
