-- [[ LSP Configuration ]]
--  See `:help lspconfig`
local lspconfig = require("lspconfig")
local mason = require("mason")
local masonlsp = require("mason-lspconfig")

-- Setup mason so it can manage external tooling
mason.setup({
	ensure_installed = {
		"stylua",
		"prettier",
	},
})

-- LSP servers to install
local servers = {
	"gopls",
	"ts_ls",
	"html",
	"cssls",
	"lua_ls",
}

-- nvim-cmp capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Generic on_attach function
-- Global LspAttach: This runs automatically whenever ANY LSP attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end,
})

masonlsp.setup({
    ensure_installed = servers,
    handlers = {
        -- Generic handler
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = capabilities,
                -- REMOVED: on_attach = on_attach 
            })
        end,
        -- Specific TS handler
        ["ts_ls"] = function()
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
           })
        end,

        -- Specific Lua handler
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                -- REMOVED: on_attach = on_attach
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    },
                },
            })
        end,
    },
})
