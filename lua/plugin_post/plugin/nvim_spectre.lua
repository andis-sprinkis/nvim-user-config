vim.cmd([[
au FileType spectre_panel setlocal signcolumn=no

nnoremap <nowait><leader>f :lua require('spectre').open()<CR>

" search current word
nnoremap <nowait><leader>fw :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <nowait><leader>fw :lua require('spectre').open_visual()<CR>

" search in current file
nnoremap <nowait><leader>fp viw:lua require('spectre').open_file_search()<cr>
]])
