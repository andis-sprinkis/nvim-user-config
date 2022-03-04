if vim.g.plug_reqr.fzf_lua then require('plugin_post.plugin.fzf_lua') end
if vim.g.plug_reqr.fzf_vim then require('plugin_post.plugin.fzf_vim') end
if vim.g.plug_reqr.git_plugins then require('plugin_post.plugin.gitsigns_nvim') end
if vim.g.plug_reqr.lsp_plugins then
  require('plugin_post.plugin.null_ls_nvim')
  require('plugin_post.plugin.nvim_lsp_installer')
end
if vim.g.plug_reqr.nvim_spectre then require('plugin_post.plugin.nvim_spectre') end
if vim.g.plug_reqr.suda then require('plugin_post.plugin.suda') end
if vim.g.plug_reqr.treesitter then require('plugin_post.plugin.nvim_treesitter') end
if vim.g.plug_reqr.vim_doge then require('plugin_post.plugin.vim_doge') end
require('plugin_post.plugin.bufstop')
require('plugin_post.plugin.colorscheme')
require('plugin_post.plugin.comment_nvim')
require('plugin_post.plugin.dirvish')
require('plugin_post.plugin.fm_nvim')
require('plugin_post.plugin.indent_blankline_nvim')
require('plugin_post.plugin.nvim_cmp')
require('plugin_post.plugin.splitjoin')
