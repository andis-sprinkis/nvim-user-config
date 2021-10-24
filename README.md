# Andis Neovim configuration files

## Initialization

[`init.lua`](init.lua) loads the configuration in following order:
1. [`lua/plugin-pre/`](lua/plugin-pre/) - configuration that needs to be set before loading plugins
   1. [`app/_init.lua`](lua/plugin-pre/app/_init.lua) - Neovim specific configuration
   1. [`plugin/_init.lua`](lua/plugin-pre/plugin/_init.lua) - plugins specific configuration
1. [`lua/plugin/`](lua/plugin/) - configuration for loading plugins
   1. [`lua/plugin/_init.lua`](lua/plugin/_init.lua) - loads [paq-nvim](https://github.com/savq/paq-nvim) bootstrap, then plugins managed by [paq-nvim](https://github.com/savq/paq-nvim) and [coc.nvim](https://github.com/neoclide/coc.nvim)
1. [`lua/plugin-post/`](lua/plugin-post/) - configuration that needs to be set after loading plugins
   1. [`app/_init.lua`](lua/plugin-post/app/_init.lua) - Neovim specific configuration
   1. [`plugin/_init.lua`](lua/plugin-post/plugin/_init.lua) - plugins specific configuration

## Requirements

[`lua/plugin-pre/requirement.lua`](lua/plugin-pre/requirement.lua) specifies external depencencies some of the plugins require, not enabling these plugins and their configurations if the dependencies are not met.

Some of the plugins (e.g. [fzf.vim](https://github.com/junegunn/fzf.vim)) require Bash compatible shell and some common *nix utilities to work. For those specific plugins to work on Microsoft Windows the [`lua/plugin-post/app/option.lua`](lua/plugin-post/app/option.lua) adds `%%ProgramFiles%%\\Git\\usr\\bin` to `%PATH%` pointing to [Git for Windows](https://gitforwindows.org/) Bash and utilities.
