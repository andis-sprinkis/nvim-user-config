ru! get-os.vim " get os
set tabstop=2 shiftwidth=2 expandtab " set default indentation
if g:os == "Windows" | let $PATH = "C:\\Program\ Files\\Git\\usr\\bin;" . $PATH | endif " bash on Windows path
