# Andis Neovim configuration files

## Initialization

[`init.lua`](init.lua) loads the configuration in following order:
1. [`lua/plugin_pre/`](lua/plugin_pre/) - configuration that needs to be set before loading plugins
   1. [`app/_init.lua`](lua/plugin_pre/app/_init.lua) - Neovim specific configuration
   1. [`plugin/_init.lua`](lua/plugin_pre/plugin/_init.lua) - plugins specific configuration
1. [`lua/plugin/`](lua/plugin/) - configuration for loading plugins
   1. [`lua/plugin/_init.lua`](lua/plugin/_init.lua) - loads [paq-nvim](https://github.com/savq/paq-nvim) bootstrap, then plugins managed by [paq-nvim](https://github.com/savq/paq-nvim) and [coc.nvim](https://github.com/neoclide/coc.nvim)
1. [`lua/plugin_post/`](lua/plugin_post/) - configuration that needs to be set after loading plugins
   1. [`app/_init.lua`](lua/plugin_post/app/_init.lua) - Neovim specific configuration
   1. [`plugin/_init.lua`](lua/plugin_post/plugin/_init.lua) - plugins specific configuration

## Requirements

[`lua/plugin_pre/requirement.lua`](lua/plugin_pre/requirement.lua) specifies external depencencies some of the plugins require, not enabling these plugins and their configurations if the dependencies are not met.

Some of the plugins (e.g. [fzf.vim](https://github.com/junegunn/fzf.vim)) require Bash compatible shell and some common *nix utilities to work. For those specific plugins to work on Microsoft Windows the [`lua/plugin_post/app/option.lua`](lua/plugin_post/app/option.lua) adds `%%ProgramFiles%%\\Git\\usr\\bin` to `%PATH%` pointing to [Git for Windows](https://gitforwindows.org/) Bash and utilities.
