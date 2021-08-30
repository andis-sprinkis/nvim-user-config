# Andis Neovim configuration files

## File structure and initialization

1. `plugin-pre/` - stores config. that needs to be set before loading of plugins
   1. `app/_init.vim` - Neovim specific configuration
   1. `plugin/_init.vim` - plugin specific configuration
1. `plugin/` - stores config. for loading the plugins
   1. `_init.vim` - loads plug.vim bootstrap, then plugins managed by [vim-plug](https://github.com/junegunn/vim-plug) and [coc.nvim](https://github.com/neoclide/coc.nvim)
1. `plugin-post/` - stores config. that needs to be set after loading of plugins
   1. `app/_init.vim` - Neovim specific configuration
   1. `plugin/_init.vim` - plugin specific configuration

`init.vim` loads Neovim configuration in the order described above.

## Requirements

See `plugin-pre/requirement.vim`.

Some plugins (e.g. [fzf.vim](https://github.com/junegunn/fzf.vim)) may require Bash compatible shell and some common *nix utilities to work on Windows. For those cases `plugin-post/app/option.vim` adds `%%ProgramFiles%%\\Git\\usr\\bin` to `%PATH%`.
