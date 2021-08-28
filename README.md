# Andis Neovim configuration files

## File structure and initialization
1. `plugin-pre/` - stores config. that needs to be set before initialization of the 3rd-party plugins
   1. `app/_init.vim` - loads Neovim specific configuration
   1. `plugin/_init.vim` - loads plugin specific configuration
1. `plugin/` - stores config. for installing and initalizing the 3rd party plugins
   1. `_init.vim` - loads plug.vim bootstrap, then initializes plugins managed by plug.vim and coc.nvim
1. `plugin-post/` - stores config. that needs to be set after initialization of the 3rd-party plugins
   1. `app/_init.vim` - loads Neovim specific configuration
   1. `plugin/_init.vim` - loads plugin specific configuration

`init.vim` loads Neovim configuration in the order described above.
