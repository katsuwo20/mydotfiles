-- luaのLSP設定ファイル

vim.lsp.config["lua_ls"] = {
  cmd ={ "lua-language-server"},
  filetypes = {
    "lua"
  },
}

vim.lsp.enable("lua_ls")
