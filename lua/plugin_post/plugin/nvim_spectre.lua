vim.cmd([[
au FileType spectre_panel setlocal signcolumn=no

" search global
nnoremap <silent><nowait><leader>r :lua require('spectre').open()<CR>
nnoremap <silent><nowait><leader>rg :lua require('spectre').open()<CR>

" search current word
nnoremap <silent><nowait><leader>rw :lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <silent><nowait><leader>rw :lua require('spectre').open_visual()<CR>

" search in current file
nnoremap <silent><nowait><leader>rf viw:lua require('spectre').open_file_search()<cr>
]])
