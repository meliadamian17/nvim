local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "gopls", "pyright", "matlab_ls", "marksman", "clangd", "elixirls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- elixir
lspconfig.elixirls.setup {
  cmd = { "/home/damianmelia/elixir-ls/language_server.sh" },
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}

-- typescript
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.sqlls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "ddl" },
}

lspconfig.matlab_ls.setup {
  settings = {
    matlab = {
      indexWorkspace = true,
      installPath = "/usr/local/MATLAB/R2024b",
      matlabConnectionTiming = "onStart",
      telemetry = false,
    },
  },
  on_init = on_init,
  on_attach = on_attach,
  capabilities = capabilities,
}
