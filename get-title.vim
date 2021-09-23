fun! GetTitle()
  if expand('%:p') == ""
    let &titlestring = "[No name] - NVIM"
  else
    let &titlestring = expand('%:p') . ' - NVIM'
  endif
endfunction
