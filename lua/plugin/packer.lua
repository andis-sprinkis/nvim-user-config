local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/andis-sprinkis/packer.nvim', install_path })
end

return require('packer').startup(function(use)
  -- 'wbthomason/packer.nvim'
  use 'andis-sprinkis/paq-nvim'
  -- 'lifepillar/vim-gruvbox8
  use 'andis-sprinkis/vim-gruvbox8'
  -- 'itchyny/lightline.vim'
  use 'andis-sprinkis/lightline.vim'
  -- 'andis-sprinkis/lightline.vim'
  use 'andis-sprinkis/lightline-gruvbox-dark.vim'
  -- 'neoclide/coc.nvim'
  if vim.g.requirementCocNvim then use { 'andis-sprinkis/coc.nvim', branch = 'release' } end
  -- 'honza/vim-snippets'
  use 'andis-sprinkis/vim-snippets'
  -- 'kassio/neoterm'
  use 'andis-sprinkis/neoterm'
  -- 'Yggdroot/indentLine'
  use 'andis-sprinkis/indentLine'
  -- 'sheerun/vim-polyglot'
  use 'andis-sprinkis/vim-polyglot'
  -- 'tpope/vim-commentary'
  use 'andis-sprinkis/vim-commentary'
  -- 'lambdalisue/suda.vim'
  if vim.g.requirementSudaVim then use 'andis-sprinkis/suda.vim' end
  -- 'justinmk/vim-dirvish'
  use 'andis-sprinkis/vim-dirvish'
  if vim.g.requirementGitPlugins then
    -- 'tpope/vim-fugitive'
    use 'andis-sprinkis/vim-fugitive'
    -- 'airblade/vim-gitgutter'
    use 'andis-sprinkis/vim-gitgutter'
    -- 'sineto/lightline-hunks'
    use 'andis-sprinkis/lightline-hunks'
    -- 'rhysd/git-messenger.vim'
    use 'andis-sprinkis/git-messenger.vim'
  end
  -- 'mihaifm/bufstop'
  use 'andis-sprinkis/bufstop'
  -- 'junegunn/fzf'
  if vim.g.requirementFzfInstall then use { 'andis-sprinkis/fzf', run = ':call fzf#install()' } end
  -- 'junegunn/fzf.vim'
  use 'andis-sprinkis/fzf.vim'
  -- 'tpope/vim-eunuch'
  use 'andis-sprinkis/vim-eunuch'
  -- 'AndrewRadev/splitjoin.vim'
  use 'andis-sprinkis/splitjoin.vim'
  -- 'editorconfig/editorconfig-vim'
  use 'andis-sprinkis/editorconfig-vim'
  -- 'pechorin/any-jump.vim'
  use 'andis-sprinkis/any-jump.vim'
  -- 'kkoomen/vim-doge'
  if vim.g.requirementVimDoge then use 'andis-sprinkis/vim-doge' end
  -- 'RRethy/vim-illuminate'
  use 'andis-sprinkis/vim-illuminate'
  -- 'Jorengarenar/vim-MvVis'
  use 'andis-sprinkis/vim-MvVis'
  -- 'dyng/ctrlsf.vim'
  use 'andis-sprinkis/ctrlsf.vim'
  -- 'chaoren/vim-wordmotion'
  use 'andis-sprinkis/vim-wordmotion'
  -- 'markonm/traces.vim'
  use 'andis-sprinkis/traces.vim'
  -- 'dhruvasagar/vim-table-mode'
  use 'andis-sprinkis/vim-table-mode'
  -- 'iamcco/markdown-preview.nvim'
  if vim.g.requirementMarkdownPreviewNvim then use { 'andis-sprinkis/markdown-preview.nvim', run = 'cd app && yarn install' } end
  -- 'antoinemadec/FixCursorHold.nvim'
  use 'andis-sprinkis/FixCursorHold.nvim'
  -- 'cdelledonne/vim-cmake'
  if vim.g.requirementVimCmake then use 'andis-sprinkis/vim-cmake' end
  -- 'alepez/vim-gtest'
  if vim.g.requirementVimGtest then use 'andis-sprinkis/vim-gtest' end

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if not packer_bootstrap == nil then
    require('packer').sync()
  end
end)
