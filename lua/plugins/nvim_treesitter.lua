local M = {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  enabled = vim.g.sys_reqr.nvim_treesitter,
  config = function()
    local disable = function()
      return vim.b.largef
    end

    local parsers = {
      'asm',
      'awk',
      'bash',
      'c',
      'cmake',
      'cpp',
      'css',
      'editorconfig',
      'git_config',
      'gitcommit',
      'gitignore',
      'html',
      'java',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'perl',
      'python',
      'styled',
      'terraform',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
      'zsh'
    }

    require('nvim-treesitter').install(parsers)

    local api = vim.api

    local ag_nvim_treesitter_cfg = api.nvim_create_augroup('nvim_treesitter_cfg', {})

    local ft = {
      'asm',
      'awk',
      'c',
      'cmake',
      'cpp',
      'css',
      'sh',
      'editorconfig',
      'git',
      'gitconfig',
      'gitignore',
      'html',
      'java',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'perl',
      'python',
      'styled',
      'terraform',
      'toml',
      'typescript',
      'typescriptreact',
      'vim',
      'vimdoc',
      'xml',
      'yaml',
      'zsh',
    }

    vim.api.nvim_create_autocmd(
      'FileType', {
        group = ag_nvim_treesitter_cfg,
        pattern = ft,
        callback = function()
          if disable() then return end

          vim.treesitter.start()

          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'

          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      }
    )
  end
}

return M
