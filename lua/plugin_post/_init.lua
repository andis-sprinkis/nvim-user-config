if vim.g.plug_reqr.fzf_lua then require('plugin_post.fzf_lua') end
if vim.g.plug_reqr.fzf_vim then require('plugin_post.fzf_vim') end
if vim.g.plug_reqr.git_plugins then require('plugin_post.gitsigns_nvim') end
if vim.g.plug_reqr.lsp_plugins then
  require('plugin_post.null_ls_nvim')
  require('plugin_post.nvim_lsp_installer')
end
if vim.g.plug_reqr.nvim_spectre then require('plugin_post.nvim_spectre') end
if vim.g.plug_reqr.suda then require('plugin_post.suda') end
if vim.g.plug_reqr.treesitter then require('plugin_post.nvim_treesitter') end
if vim.g.plug_reqr.vim_doge then require('plugin_post.vim_doge') end
require('plugin_post.bufstop')
require('plugin_post.colorscheme')
require('plugin_post.comment_nvim')
require('plugin_post.dirvish')
require('plugin_post.fm_nvim')
require('plugin_post.indent_blankline_nvim')
require('plugin_post.nvim_cmp')
require('plugin_post.splitjoin')
