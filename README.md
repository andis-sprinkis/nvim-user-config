# Andis Neovim configuration files

## Initialization

`init.lua` entrypoint loads the configuration in order:
1. `lua/plugin-pre/` - configuration that needs to be set before loading of plugins
   1. `lua/app/_init.lua` - Neovim specific configuration
   1. `lua/plugin/_init.lua` - plugin specific configuration
1. `lua/plugin/` - configuration for loading the plugins
   1. `_init.lua` - loads [paq-nvim](https://github.com/savq/paq-nvim) bootstrap, then the plugins managed by [paq-nvim](https://github.com/savq/paq-nvim) and [coc.nvim](https://github.com/neoclide/coc.nvim)
1. `lua/plugin-post/` - configuration that needs to be set after loading of plugins
   1. `lua/app/_init.lua` - Neovim specific configuration
   1. `lua/plugin/_init.lua` - plugin specific configuration

## Requirements

See `lua/plugin-pre/requirement.lua`.

Some plugins (e.g. [fzf.vim](https://github.com/junegunn/fzf.vim)) may require Bash compatible shell and some common *nix utilities to work on Windows. For those cases `lua/plugin-post/app/option.lua` adds `%%ProgramFiles%%\\Git\\usr\\bin` to `%PATH%`.
