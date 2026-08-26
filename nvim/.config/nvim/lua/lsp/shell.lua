-- shellのLSP設定ファイル

local lsp = require("lsp.util")

if vim.fn.executable("bash-language-server") == 1 then
  vim.lsp.config["bashls"] = {
    capabilities = lsp.capabilities,
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash", "zsh", "csh", "tcsh" },
  }

  vim.lsp.enable("bashls")
end

