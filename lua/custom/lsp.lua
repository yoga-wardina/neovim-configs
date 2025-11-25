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
local on_attach = function(client, bufnr)
	-- See `:help vim.lsp.buf` for more information
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
end

masonlsp.setup({
	ensure_installed = servers,
	handlers = {
		-- The first argument is the server name
		-- The second argument is the config object
		function(server_name)
			lspconfig[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,

		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			})
		end,

		["ts_ls"] = function()
        lspconfig.ts_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            -- Force it to look for tsconfig.json to avoid single-file mode
            root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
        })
    end,
	},
})
