# Andis Neovim configuration files

## Installation

Via *nix shell:

```bash
git clone https://github.com/andis-sprinkis/nvim-user-config $HOME/.config/nvim
```

Via CMD/PS on Windows:

```dos
git clone https://github.com/andis-sprinkis/nvim-user-config %APPDATA%\Local\nvim
```

### Minimal config option

Alternative minimal configuration without any of the mentioned plugins or dependencies:

```bash
git checkout minimal-config
```

## Initialization

[`init.lua`](init.lua) loads the configuration in following order:

1. [`lua/plugin_pre/`](lua/plugin_pre/) - configuration that needs to be set before loading plugins
   1. [`app/_init.lua`](lua/plugin_pre/app/_init.lua) - Neovim specific configuration
   1. [`plugin/_init.lua`](lua/plugin_pre/plugin/_init.lua) - plugins specific configuration
1. [`lua/plugin/`](lua/plugin/) - configuration for loading plugins
   1. [`lua/plug.lua`](lua/plug.lua) - loads [vim-plug](https://github.com/junegunn/vim-plug) bootstrap and plugins managed by it
1. [`lua/plugin_post/`](lua/plugin_post/) - configuration that needs to be set after loading plugins
   1. [`app/_init.lua`](lua/plugin_post/app/_init.lua) - Neovim specific configuration
   1. [`plugin/_init.lua`](lua/plugin_post/plugin/_init.lua) - plugins specific configuration
1. [`lua/statusline.lua`](lua/statusline.lua) - sets statusline

## Dependencies

- System:
  - `bash`
  - `git`
  - `lua-language-server`
  - `node`
  - `sed`
  - `tree-sitter`
- NPM:
  - `bash-language-server`
  - `stylelint-lsp`
  - `typescript-language-server`
  - `typescript`
  - `vscode-langservers-extracted`
