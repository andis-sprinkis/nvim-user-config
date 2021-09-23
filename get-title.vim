fun! GetTitle()
  if expand('%:p') == ""
    let &titlestring = "[No name] - Neovim"
  else
    let &titlestring = expand('%:p') . ' - Neovim'
  endif
endfun
