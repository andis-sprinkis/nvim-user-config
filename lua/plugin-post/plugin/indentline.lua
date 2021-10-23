vim.g.indentLine_color_gui = '#3C3836'
vim.g.indentLine_char = '│'
vim.g.indentLine_showFirstIndentLevel = 1
vim.g.indentLine_first_char = '│'
vim.g.indentLine_fileTypeExclude = { 'help', 'terminal', 'man', 'any-jump', 'packer' }

vim.api.nvim_exec([[
au TermOpen * IndentLinesDisable
au FileType markdown let g:indentLine_setConceal=0
]], false)
