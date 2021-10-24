local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim';
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/andis-sprinkis/paq-nvim.git', install_path})
end

local packages = {
  -- 'savq/paq-nvim';
  'andis-sprinkis/paq-nvim';
  -- 'wbthomason/packer.nvim';
  'andis-sprinkis/paq-nvim';
  -- 'lifepillar/vim-gruvbox8
  'andis-sprinkis/vim-gruvbox8';
  -- 'itchyny/lightline.vim';
  'andis-sprinkis/lightline.vim';
  -- 'andis-sprinkis/lightline.vim';
  'andis-sprinkis/lightline-gruvbox-dark.vim';
  -- 'honza/vim-snippets';
  'andis-sprinkis/vim-snippets';
  -- 'kassio/neoterm';
  'andis-sprinkis/neoterm';
  -- 'Yggdroot/indentLine';
  'andis-sprinkis/indentLine';
  -- 'sheerun/vim-polyglot';
  'andis-sprinkis/vim-polyglot';
  -- 'tpope/vim-commentary';
  'andis-sprinkis/vim-commentary';
  -- 'justinmk/vim-dirvish';
  'andis-sprinkis/vim-dirvish';
  -- 'mihaifm/bufstop';
  'andis-sprinkis/bufstop';
  -- 'junegunn/fzf.vim'
  'andis-sprinkis/fzf.vim'
  -- 'tpope/vim-eunuch';
  'andis-sprinkis/vim-eunuch';
  -- 'AndrewRadev/splitjoin.vim';
  'andis-sprinkis/splitjoin.vim';
  -- 'editorconfig/editorconfig-vim';
  'andis-sprinkis/editorconfig-vim';
  -- 'pechorin/any-jump.vim';
  'andis-sprinkis/any-jump.vim';
  -- 'RRethy/vim-illuminate';
  'andis-sprinkis/vim-illuminate';
  -- 'Jorengarenar/vim-MvVis';
  'andis-sprinkis/vim-MvVis';
  -- 'dyng/ctrlsf.vim';
  'andis-sprinkis/ctrlsf.vim';
  -- 'chaoren/vim-wordmotion';
  'andis-sprinkis/vim-wordmotion';
  -- 'markonm/traces.vim';
  'andis-sprinkis/traces.vim';
  -- 'dhruvasagar/vim-table-mode';
  'andis-sprinkis/vim-table-mode';
  -- 'iamcco/markdown-preview.nvim';
  { 'andis-sprinkis/markdown-preview.nvim', run = vim.fn['mkdp#util#install'] };
  -- 'antoinemadec/FixCursorHold.nvim';
  'andis-sprinkis/FixCursorHold.nvim';
}

-- 'neoclide/coc.nvim';
if vim.g.requirementCocNvim then table.insert(packages, { 'andis-sprinkis/coc.nvim', branch = 'release' }) end
-- 'lambdalisue/suda.vim'
if vim.g.requirementSudaVim then table.insert(packages, 'andis-sprinkis/suda.vim') end
if vim.g.requirementGitPlugins then
  -- 'tpope/vim-fugitive';
  table.insert(packages, 'andis-sprinkis/vim-fugitive')
  -- 'airblade/vim-gitgutter';
  table.insert(packages, 'andis-sprinkis/vim-gitgutter')
  -- 'sineto/lightline-hunks';
  table.insert(packages, 'andis-sprinkis/lightline-hunks')
  -- 'rhysd/git-messenger.vim';
  table.insert(packages, 'andis-sprinkis/git-messenger.vim')
end
-- 'junegunn/fzf'
if vim.g.requirementFzfInstall then table.insert(packages, { 'andis-sprinkis/fzf', run = vim.fn['fzf#install'] }) end
-- 'kkoomen/vim-doge'
if vim.g.requirementVimDoge then table.insert(packages, 'andis-sprinkis/vim-doge') end
-- 'iamcco/markdown-preview.nvim'
if vim.g.requirementMarkdownPreviewNvim then table.insert(packages, { 'andis-sprinkis/markdown-preview.nvim', run = 'cd app && yarn install' }) end
-- 'cdelledonne/vim-cmake'
if vim.g.requirementVimCmake then table.insert(packages, 'andis-sprinkis/vim-cmake') end
-- 'alepez/vim-gtest'
if vim.g.requirementVimGtest then table.insert(packages, 'andis-sprinkis/vim-gtest') end

require('paq')(packages)
