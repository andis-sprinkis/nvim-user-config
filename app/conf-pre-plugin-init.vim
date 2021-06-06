" get os
runtime! get-os.vim

" set default indentation
set tabstop=2 shiftwidth=2 expandtab

" bash on Windows path
if g:os == "Windows"
  let $PATH = "C:\\Program\ Files\\Git\\usr\\bin;" . $PATH
endif
