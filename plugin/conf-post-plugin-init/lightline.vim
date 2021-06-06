" lightline setup
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \     ['lightline_hunks', 'readonly', 'relativepath', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \     [ 'percent' ],
  \     [ 'filetype' ] ]
  \ },
  \ 'inactive': {
  \   'left': [
  \     ['lightline_hunks', 'readonly', 'relativepath', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \     [ 'percent' ] ,
  \     [ 'filetype' ] ]
  \  },
  \ 'component_function': {
  \   'lightline_hunks': 'lightline#hunks#composer',
  \ }
\ }

let g:lightline.colorscheme = 'gruvboxdark'
