-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
capabilities.offsetEncoding = { "utf-16" }

local lspconfig = require "lspconfig"
local servers = { "lua_ls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup {
  cmd = {"clangd", "--completion-style=detailed"},
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
