lua <<EOF
-- Determine OS
require('get_os')

local font_name = 'Cascadia Code PL'
local font_size = 13

function AdjustFontSize(amount)
  font_size = font_size + amount
  vim.api.nvim_command('GuiFont! ' .. font_name .. ':h' .. tostring(font_size))
end

AdjustFontSize(0)

vim.api.nvim_set_keymap('n', '<C-ScrollWheelUp>', ':lua AdjustFontSize(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-ScrollWheelDown>', ':lua AdjustFontSize(-1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-ScrollWheelUp>', '<Esc>:lua AdjustFontSize(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-ScrollWheelDown>', '<Esc>:lua AdjustFontSize(-1)<CR>', { noremap = true, silent = true })

-- disable GUI widgets
vim.cmd([[
GuiPopupmenu 0
GuiTabline 0
]])

-- go to partition root when no path specified
if vim.g.os == 'Windows' and vim.fn.expand('%:p') == '' then
  vim.api.nvim_command('cd /')
end
EOF
