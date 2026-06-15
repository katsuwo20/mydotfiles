-- ===============================
-- lualine 設定
-- ===============================

local colors = {
	bg = "#1e1e1e",
	fg = "#d4d4d4",
	blue = "#007acc",
	green = "#89d185",
	yellow = "#dcdcaa",
	red = "#f14c4c",
	gray = "#2d2d30",
}

local vscode_theme = {
	normal = {
		a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
		b = { fg = colors.fg, bg = colors.gray },
		c = { fg = colors.fg, bg = colors.bg },
	},
	insert = { a = { fg = colors.bg, bg = colors.green, gui = "bold" } },
	visual = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
	replace = { a = { fg = colors.bg, bg = colors.red, gui = "bold" } },
	command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
	inactive = {
		a = { fg = colors.fg, bg = colors.gray, gui = "bold" },
		b = { fg = colors.fg, bg = colors.gray },
		c = { fg = colors.fg, bg = colors.bg },
	},
}

local function lsp_name()
	local clients = {}

	if vim.lsp.get_clients then
		clients = vim.lsp.get_clients({ bufnr = 0 })
	else
		clients = vim.lsp.buf_get_clients(0)
	end

	if not clients or vim.tbl_isempty(clients) then
		return "LSP: off"
	end

	local names = {}
	for _, client in pairs(clients) do
		table.insert(names, client.name)
	end

	return "LSP: " .. table.concat(names, ",")
end

local function indent_size()
	local size = vim.bo.shiftwidth
	if size == 0 then
		size = vim.bo.tabstop
	end
	return "spaces:" .. tostring(size)
end

local function file_encoding()
	local enc = vim.bo.fileencoding
	if enc == nil or enc == "" then
		enc = vim.o.encoding
	end
	return string.upper(enc)
end

local function line_ending()
	local ff = vim.bo.fileformat
	if ff == "unix" then
		return "LF"
	end
	if ff == "dos" then
		return "CRLF"
	end
	if ff == "mac" then
		return "CR"
	end
	return ff
end

require("lualine").setup({
	options = {
		theme = vscode_theme,
		globalstatus = true,
		section_separators = "",
		component_separators = "|",
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(mode)
					return "NVIM " .. mode
				end,
			},
		},
		lualine_b = {
			{ "branch", icon = "" },
			{
				"diff",
				symbols = { added = "+", modified = "~", removed = "-" },
			},
		},
		lualine_c = {
			{
				"filename",
				path = 1,
				symbols = {
					modified = " ●",
					readonly = " [RO]",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
			},
			lsp_name,
		},
		lualine_y = { indent_size, file_encoding, line_ending, "filetype" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
