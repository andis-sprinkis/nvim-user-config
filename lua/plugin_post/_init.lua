local with_reqr = require('util').with_reqr

local modules = {
  {
    dependant = { modules = { 'impatient' } },
    dependency = { plugs = { 'impatient.nvim' } }
  },
  {
    dependant = { modules = { 'plugin_post.fzf_lua' } },
    dependency = { sys_reqr = { 'fzf_lua' }, plugs = { 'fzf-lua' } }
  },
  {
    dependant = { modules = { 'plugin_post.fzf_vim' } },
    dependency = { sys_reqr = { 'fzf_vim' }, plugs = { 'fzf.vim' } }
  },
  {
    dependant = { modules = { 'plugin_post.gitsigns_nvim' } },
    dependency = { sys_reqr = { 'git_plugins' }, plugs = { 'gitsigns.nvim' } }
  },
  {
    dependant = { modules = { 'plugin_post.null_ls_nvim', 'plugin_post.nvim_lsp_installer' } },
    dependency = { sys_reqr = { 'lsp_plugins' }, plugs = { 'null-ls.nvim', 'nvim-lsp-installer' } }
  },
  {
    dependant = { modules = { 'plugin_post.nvim_spectre' } },
    dependency = { sys_reqr = { 'nvim_spectre' }, plugs = { 'nvim-spectre' } }
  },
  {
    dependant = { modules = { 'plugin_post.suda' } },
    dependency = { sys_reqr = { 'suda_vim' }, plugs = { 'suda.vim' } }
  },
  {
    dependant = { modules = { 'plugin_post.nvim_treesitter' } },
    dependency = { sys_reqr = { 'treesitter' }, plugs = { 'nvim-treesitter' } }
  },
  {
    dependant = { modules = { 'plugin_post.vim_doge' } },
    dependency = { sys_reqr = { 'vim_doge' }, plugs = { 'vim-doge' } },
  },
  {
    dependant = { modules = { 'plugin_post.bufstop' } },
    dependency = { plugs = { 'bufstop' } },
  },
  {
    dependant = { modules = { 'plugin_post.colorscheme' } },
    dependency = { plugs = { 'vscode.nvim' } }
  },
  {
    dependant = { modules = { 'plugin_post.comment_nvim' } },
    dependency = { plugs = { 'Comment.nvim' } }
  },
  {
    dependant = { modules = { 'plugin_post.dirvish' } },
    dependency = { plugs = { 'vim-dirvish' } }
  },
  {
    dependant = { modules = { 'plugin_post.fm_nvim' } },
    dependency = { plugs = { 'fm-nvim' } }
  },
  {
    dependant = { modules = { 'plugin_post.indent_blankline_nvim' } },
    dependency = { plugs = { 'indent-blankline.nvim' } }
  },
  {
    dependant = { modules = { 'plugin_post.nvim_cmp' } },
    dependency = { plugs = { 'nvim-cmp', 'luasnip' } }
  },
  {
    dependant = { modules = { 'plugin_post.splitjoin' } },
    dependency = { plugs = { 'splitjoin.vim' } }
  },
  {
    dependant = { modules = { 'plugin_post.statusline' } },
    dependency = { sys_reqr = { 'git_plugins', 'lsp_plugins' }, plugs = { 'nvim-lsp-installer', 'null-ls.nvim', 'gitsigns.nvim' } },
  },
}

for _, value in ipairs(modules) do with_reqr(value) end
