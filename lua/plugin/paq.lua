local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim';
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/andis-sprinkis/paq-nvim.git', install_path})
end

require "paq" {
  --  "savq/paq-nvim";
  'andis-sprinkis/paq-nvim';
  -- 'wbthomason/packer.nvim';
  'andis-sprinkis/paq-nvim';
  -- 'lifepillar/vim-gruvbox8
  'andis-sprinkis/vim-gruvbox8';
  -- 'itchyny/lightline.vim';
  'andis-sprinkis/lightline.vim';
  -- 'andis-sprinkis/lightline.vim';
  'andis-sprinkis/lightline-gruvbox-dark.vim';
  -- 'neoclide/coc.nvim';
  { 'andis-sprinkis/coc.nvim', branch = 'release' };
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
  -- 'lambdalisue/suda.vim';
  'andis-sprinkis/suda.vim';
  -- 'justinmk/vim-dirvish';
  'andis-sprinkis/vim-dirvish';
  -- 'tpope/vim-fugitive';
  'andis-sprinkis/vim-fugitive';
  -- 'airblade/vim-gitgutter';
  'andis-sprinkis/vim-gitgutter';
  -- 'sineto/lightline-hunks';
  'andis-sprinkis/lightline-hunks';
  -- 'rhysd/git-messenger.vim';
  'andis-sprinkis/git-messenger.vim';
  -- 'mihaifm/bufstop';
  'andis-sprinkis/bufstop';
  -- 'junegunn/fzf';
  { 'andis-sprinkis/fzf', run = 'fzf#install' };
  -- 'junegunn/fzf.vim';
  'andis-sprinkis/fzf.vim';
  -- 'tpope/vim-eunuch';
  'andis-sprinkis/vim-eunuch';
  -- 'AndrewRadev/splitjoin.vim';
  'andis-sprinkis/splitjoin.vim';
  -- 'editorconfig/editorconfig-vim';
  'andis-sprinkis/editorconfig-vim';
  -- 'pechorin/any-jump.vim';
  'andis-sprinkis/any-jump.vim';
  -- 'kkoomen/vim-doge';
  'andis-sprinkis/vim-doge';
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
  { 'andis-sprinkis/markdown-preview.nvim', run = 'cd app && yarn install' };
  -- 'antoinemadec/FixCursorHold.nvim';
  'andis-sprinkis/FixCursorHold.nvim';
  -- 'cdelledonne/vim-cmake';
  'andis-sprinkis/vim-cmake';
  -- 'alepez/vim-gtest';
  'andis-sprinkis/vim-gtest';
}
