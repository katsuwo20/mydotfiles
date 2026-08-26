-- luaのLSP設定ファイル
local lsp = require("lsp.util")

if vim.fn.executable("lua-language-server") == 1 then
  vim.lsp.config["lua_ls"] = {
    capabilities = lsp.capabilities,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  }

  vim.lsp.enable("lua_ls")
end
