if vim.g.meetsPlugRequirement.cocNvim then
  require('plugin-post.plugin.coc') 
  vim.cmd('ru! plugin-post/plugin/coc.vim')
end

if vim.g.meetsPlugRequirement.fzfVim then require('plugin-post.plugin.fzf') end
if vim.g.meetsPlugRequirement.gitPlugins then require('plugin-post.plugin.gitgutter') end
if vim.g.meetsPlugRequirement.suda then require('plugin-post.plugin.suda') end
if vim.g.meetsPlugRequirement.vimDoge then require('plugin-post.plugin.vim-doge') end

require('plugin-post.plugin.anyjump')
require('plugin-post.plugin.bufstop')
require('plugin-post.plugin.dirvish')
require('plugin-post.plugin.indentline')
require('plugin-post.plugin.lightline')
require('plugin-post.plugin.splitjoin')
require('plugin-post.plugin.vim-gruvbox8')
