" gitgutter
let g:gitgutter_override_sign_column_highlight = 1
autocmd BufWritePost,WinEnter * GitGutter

" jump between git hunks
nmap <Leader>hn <Plug>GitGutterNextHunk
nmap <Leader>hp <Plug>GitGutterPrevHunk
