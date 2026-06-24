-- luaのLSP設定ファイル
local lsp = require("lsp.util")

vim.lsp.config["lua_ls"] = {
  capabilities = lsp.capabilities,
  cmd ={ "lua-language-server"},
  filetypes = {
    "lua"
  },
}

vim.lsp.enable("lua_ls")
