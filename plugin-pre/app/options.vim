ru! get-os.vim " get os
set tabstop=2 shiftwidth=2 expandtab " set default indentation
if !exists("g:nogit") | let g:nogit = 0 | endif " toggle enable git plugins & related config. on startup
if g:os == "Windows" | let $PATH = "C:\\Program\ Files\\Git\\usr\\bin;" . $PATH | endif " set bash on Windows path
