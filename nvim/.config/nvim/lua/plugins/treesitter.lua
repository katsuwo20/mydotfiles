-- nvim-treesitter (main branch, Neovim 0.12+)
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- パーサーのインストール (非同期)
require("nvim-treesitter").install({
	"c",
	"cpp",
	"bash",
	"css",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"rust",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
})

-- ハイライト・インデントを有効化
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c", "cpp", "bash", "sh", "css", "go", "html", "javascript", "json",
		"lua", "markdown", "python", "query", "rust", "toml", "tsx",
		"typescript", "vim", "vimdoc", "yaml",
	},
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
