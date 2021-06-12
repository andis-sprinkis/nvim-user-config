if !executable("git")
  let g:nogit = 1
else
  if !exists("g:nogit")
    let g:nogit = 0
  endif
endif
