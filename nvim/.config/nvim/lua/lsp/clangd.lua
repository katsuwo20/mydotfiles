-- C/C++のLSP設定ファイル

local lsp = require("lsp.util")

vim.lsp.config["clangd"] = {
  capabilities = lsp.capabilities,
  cmd ={ "clangd"},
  filetypes ={
    "c",
    "cpp",
  },
}

vim.lsp.enable("clangd")
