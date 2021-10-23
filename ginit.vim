lua <<< EOF
-- Determine OS
vim.api.nvim_exec([[
ru! get-os.vim
]])

local fontname = 'Cascadia Code PL'
local fontsize = 13

function AdjustFontSize(amount)
  fontsize = fontsize + amount
  vim.api.nvim_command('GuiFont! ' .. fontname .. ':h' .. tostring(fontsize))
end

AdjustFontSize(0)

vim.api.nvim_set_keymap('n', '<C-ScrollWheelUp>', ':lua AdjustFontSize(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-ScrollWheelDown>', ':lua AdjustFontSize(-1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-ScrollWheelUp>', '<Esc>:lua AdjustFontSize(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-ScrollWheelDown>', '<Esc>:lua AdjustFontSize(-1)<CR>', { noremap = true, silent = true })

-- disable GUI widgets
vim.api.nvim_exec([[
GuiPopupmenu 0
GuiTabline 0
]], false)

-- go to partition root when no path specified
if vim.g.os == 'Windows' and vim.fn.expand('%:p') == '' then
  vim.api.nvim_command('cd /')
end
EOF
