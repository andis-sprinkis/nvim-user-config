let g:indentLine_color_gui = '#3c3836'
let g:indentLine_char = '▏'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char = '▏'
let g:indentLine_fileTypeExclude = ['help', 'terminal', 'markdown.mdx', 'markdown']
autocmd TermOpen * IndentLinesDisable
autocmd FileType markdown IndentLinesDisable
autocmd FileType markdown.mdx IndentLinesDisable
