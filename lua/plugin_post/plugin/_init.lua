if vim.g.meets_plug_requirement.coc_nvim then vim.cmd('ru! lua/plugin_post/plugin/coc.vim') end
if vim.g.meets_plug_requirement.fzf_vim then require('plugin_post.plugin.fzf') end
if vim.g.meets_plug_requirement.git_plugins then require('plugin_post.plugin.gitgutter') end
if vim.g.meets_plug_requirement.nvim_spectre then require('plugin_post.plugin.nvim_spectre') end
if vim.g.meets_plug_requirement.suda then require('plugin_post.plugin.suda') end
if vim.g.meets_plug_requirement.vim_doge then require('plugin_post.plugin.vim_doge') end

require('plugin_post.plugin.bufstop')
require('plugin_post.plugin.dirvish')
require('plugin_post.plugin.indentline')
require('plugin_post.plugin.lightline')
-- require('plugin_post.plugin.lualine_nvim')
require('plugin_post.plugin.splitjoin')
require('plugin_post.plugin.vim_gruvbox8')
