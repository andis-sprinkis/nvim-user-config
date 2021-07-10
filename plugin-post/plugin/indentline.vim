let g:indentLine_color_gui = '#3C3836'
let g:indentLine_char = '│'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_first_char = '│'
let g:indentLine_fileTypeExclude = ['help', 'terminal', 'man']
au TermOpen * IndentLinesDisable
au FileType markdown let g:indentLine_setConceal=0
