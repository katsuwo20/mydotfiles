-- lua/lsp/init.lua

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
})

-- LspAttach 時のバッファローカルキーマップ（gd / gr / gk / <leader>rn）は
-- core/keymaps.lua に集約。

require("lsp.lua_ls")
require("lsp.clangd")
require("lsp.shell")
