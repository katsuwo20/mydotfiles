-- C/C++のLSP設定ファイル

local lsp = require("lsp.util")

if vim.fn.executable("clangd") == 1 then
  vim.lsp.config["clangd"] = {
    capabilities = lsp.capabilities,
    cmd = { "clangd" },
    filetypes = { "c", "cpp" },
  }

  vim.lsp.enable("clangd")
end
