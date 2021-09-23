let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent exe '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
    \ "https://raw.githubusercontent.com/andis-sprinkis/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path
