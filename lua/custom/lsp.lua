-- [[ LSP Configuration ]]
--  See `:help lspconfig`
local lspconfig = require('lspconfig')
local mason = require('mason')
local masonlsp = require('mason-lspconfig')

mason.setup()
masonlsp.setup({
  ensure_installed = {
    'gopls',
    'tsserver',
    'html',
    'cssls',
    'lua_ls',
  },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
})
