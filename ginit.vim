" Determine OS
ru! get-os.vim

lua <<EOF
local fontname = 'Cascadia Code PL'
local fontsize = 13

function _G.AdjustFontSize(amount)
  fontsize = fontsize + amount
  vim.api.nvim_command('GuiFont! ' .. fontname .. ':h' .. tostring(fontsize))
end

_G.AdjustFontSize(0)

vim.api.nvim_set_keymap('n', '<C-ScrollWheelUp>', 'lua _G.AdjustFontSize(1)<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-ScrollWheelDown>', ':lua _G.AdjustFontSize(-1)<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-ScrollWheelUp>', '<Esc>:lua _G.AdjustFontSize(1)<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-ScrollWheelDown>', '<Esc>:lua G.AdjustFontSize(-1)<CR>', { noremap = true })

-- disable GUI widgets
vim.api.nvim_exec([[
GuiPopupmenu 0
GuiTabline 0
]], true)

-- go to partition root when no path specified
if vim.g.os == 'Windows' and vim.fn.expand('%:p') == '' then
  vim.api.nvim_command('cd /')
end
EOF
