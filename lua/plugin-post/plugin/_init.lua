if vim.g.requirementCocNvim == true then require('plugin-post.plugin.coc') end
if vim.g.requirementFzfVim then require('plugin-post.plugin.fzf') end
if vim.g.requirementGitPlugins == true then require('plugin-post.plugin.gitgutter') end
if vim.g.requirementSudaVim == true then require('plugin-post.plugin.suda') end
if vim.g.requirementVimDoge == true then require('plugin-post.plugin.vim-doge') end
require('plugin-post.plugin.anyjump')
require('plugin-post.plugin.bufstop')
require('plugin-post.plugin.dirvish')
require('plugin-post.plugin.indentline')
require('plugin-post.plugin.lightline')
require('plugin-post.plugin.splitjoin')
require('plugin-post.plugin.vim-gruvbox8')
vim.cmd('if g:requirementCocNvim | ru! plugin-post/plugin/coc.vim | endif')
