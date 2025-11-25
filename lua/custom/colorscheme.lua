-- [[ Setting the Colorscheme ]]
--  See `:help colorscheme`

local M = {}

function M.changeColor(theme)
  theme = theme or 'dracula'
  local success, _ = pcall(vim.cmd, 'colorscheme ' .. theme)
  if not success then
    vim.notify('Colorscheme ' .. theme .. ' not found!', vim.log.levels.ERROR)
    return
  end
  -- set the background to dark
  vim.o.background = 'dark'
end

M.changeColor()

_G.changeColor = M.changeColor

return M

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
