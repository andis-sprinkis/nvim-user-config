if !executable("git")
  let g:nogitplugin = 1
else
  if !exists("g:nogitplugin") | let g:nogitplugin = 0 | endif
endif
