-- [[ Basic Keymaps ]]
--  See `:help keymaps`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Telescope Keymaps ]]
--  The Telescope keymaps will only work after the Telescope plugin is installed.
--  I am using <C-S-p> for searching non-git files, as SUPER is not a standard modifier key in terminals.
--  You can change this to a different keybinding if you prefer.
vim.keymap.set('n', '<C-p>', function()
  require('telescope.builtin').git_files()
end, { desc = '[C-p] a file in git repository' })
vim.keymap.set('n', '<C-S-p>', function()
  require('telescope.builtin').find_files()
end, { desc = '[C-S-p] a file' })

-- [[ Nvim-tree Keymaps ]]
vim.keymap.set('n', '<leader>qp', function()
  require('nvim-tree.api').tree.toggle()
end, { desc = 'Toggle nvim-tree' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
