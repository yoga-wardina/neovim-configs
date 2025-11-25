return {
  -- Dracula theme
  { 'dracula/vim', name = 'dracula' },

  -- Telescope for file searching
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {}
    end,
  },

  -- Nvim-tree for file exploring
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup()
    end,
  },

  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -- Formatter
  -- You need to install the formatters on your system.
  -- For example, for prettier: npm install -g prettier
  -- For stylua: cargo install stylua
  {
    'mhartington/formatter.nvim',
    config = function()
      require('formatter').setup {
        filetype = {
          javascript = {
            require('formatter.filetypes.javascript').prettier,
          },
          typescript = {
            require('formatter.filetypes.typescript').prettier,
          },
          html = {
            require('formatter.filetypes.html').prettier,
          },
          css = {
            require('formatter.filetypes.css').prettier,
          },
          lua = {
            require('formatter.filetypes.lua').stylua,
          },
          go = {
            require('formatter.filetypes.go').gofmt,
          }
        },
      }

      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*',
        callback = function()
          vim.cmd 'FormatWrite'
        end,
      })
    end,
  },
}
