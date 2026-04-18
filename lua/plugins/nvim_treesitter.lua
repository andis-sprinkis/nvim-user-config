local M = {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  enabled = vim.g.sys_reqr.nvim_treesitter,
  config = function()
    -- https://github.com/nvim-treesitter/nvim-treesitter/tree/main/runtime/queries
    -- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/plugin/filetypes.lua

    local parsers = {
      'asm',
      'awk',
      'bash',
      'c',
      'cmake',
      'comment',
      'cpp',
      'css',
      'csv',
      'desktop',
      'diff',
      'editorconfig',
      'embedded_template',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'html',
      'ini',
      'java',
      'javascript',
      'json',
      'jsx',
      'lua',
      'make',
      'markdown',
      'perl',
      'python',
      'ssh_config',
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
      'confini',
      'cpp',
      'css',
      'csv',
      'desktop',
      'dosini',
      'editorconfig',
      'git',
      'gitconfig',
      'gitdiff',
      'gitignore',
      'gitrebase',
      'go',
      'html',
      'java',
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'lua',
      'make',
      'markdown',
      'perl',
      'python',
      'sh',
      'sshconfig',
      'styled',
      'svg',
      'terraform',
      'terraform-vars',
      'toml',
      'typescript',
      'typescript.tsx',
      'typescriptreact',
      'vim',
      'vimdoc',
      'xml',
      'xsd',
      'xslt',
      'yaml',
      'zsh',
    }

    vim.api.nvim_create_autocmd(
      'FileType', {
        group = ag_nvim_treesitter_cfg,
        pattern = ft,
        callback = function()
          if vim.b.largef then return end

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
