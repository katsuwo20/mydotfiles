-- ===============================
-- persistence.nvim 設定
-- ===============================

local persistence = require("persistence")

local function wipe_neotree_buffers()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) then
			local ft = vim.bo[buf].filetype
			local name = vim.api.nvim_buf_get_name(buf)
			if ft == "neo-tree" or name:match("neo%-tree") then
				pcall(vim.api.nvim_buf_delete, buf, { force = true })
			end
		end
	end
end

persistence.setup({
	-- セッション保存先
	dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
	-- バッファ・タブ・ウィンドウ情報を復元
	options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
})

-- neo-tree の特殊バッファは保存しない（名前衝突エラー回避）
vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceSavePre",
	callback = function()
		pcall(vim.cmd, "silent! Neotree close")
		wipe_neotree_buffers()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceLoadPre",
	callback = function()
		wipe_neotree_buffers()
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "PersistenceLoadPost",
	callback = function()
		wipe_neotree_buffers()
	end,
})

-- VSCode ワークスペース風: ディレクトリを開いたとき前回セッションを自動復元
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- 古いセッション由来の neo-tree バッファが残っている場合に備えて掃除
		wipe_neotree_buffers()

		if vim.fn.argc() == 0 then
			persistence.load()
			return
		end

		if vim.fn.argc() == 1 then
			local arg0 = vim.fn.argv(0)
			if vim.fn.isdirectory(arg0) == 1 then
				persistence.load()
			end
		end
	end,
})

-- 明示的な保存/復元キーマップ
vim.keymap.set("n", "<leader><leader>ss", function()
	persistence.save()
end, { desc = "Session save" })

vim.keymap.set("n", "<leader><leader>sl", function()
	persistence.load()
end, { desc = "Session load" })

vim.keymap.set("n", "<leader><leader>sd", function()
	persistence.stop()
end, { desc = "Session stop" })
