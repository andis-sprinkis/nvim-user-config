local autoload_plug_path = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
if vim.fn.filereadable(autoload_plug_path) == 0 then
  vim.cmd('!curl -fLo ' .. autoload_plug_path .. '  --create-dirs "https://raw.githubusercontent.com/andis-sprinkis/vim-plug/master/plug.vim"')
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

vim.fn['plug#begin']()

if vim.g.plug_requirement.git_plugins then
  vim.cmd([[
    Plug 'andis-sprinkis/git-messenger.vim'
    Plug 'andis-sprinkis/vim-fugitive'
    Plug 'andis-sprinkis/gitsigns.nvim'
  ]])
end

vim.cmd([[
Plug 'andis-sprinkis/plenary.nvim'
Plug 'andis-sprinkis/FixCursorHold.nvim'
Plug 'andis-sprinkis/bufstop'
Plug 'andis-sprinkis/editorconfig-vim'
Plug 'andis-sprinkis/indentLine'
Plug 'andis-sprinkis/neoterm'
Plug 'andis-sprinkis/registers.nvim'
Plug 'andis-sprinkis/splitjoin.vim'
Plug 'andis-sprinkis/traces.vim'
Plug 'andis-sprinkis/vim-MvVis'
Plug 'andis-sprinkis/vim-commentary'
Plug 'andis-sprinkis/vim-dirvish'
Plug 'andis-sprinkis/vim-eunuch'
Plug 'andis-sprinkis/vim-gruvbox8'
Plug 'andis-sprinkis/vim-illuminate'
Plug 'andis-sprinkis/vim-polyglot'
Plug 'andis-sprinkis/vim-snippets'
Plug 'andis-sprinkis/vim-table-mode'
Plug 'andis-sprinkis/vim-wordmotion'
]])

if vim.g.plug_requirement.fzf_install then vim.cmd('Plug \'andis-sprinkis/fzf\', { \'do\': { -> fzf#install() } }') end
if vim.g.plug_requirement.fzf_lua then
vim.cmd([[
Plug 'andis-sprinkis/fzf-lua'
Plug 'andis-sprinkis/nvim-fzf'
]])
end
if vim.g.plug_requirement.fzf_vim then vim.cmd('Plug \'andis-sprinkis/fzf.vim\'') end

if vim.g.plug_requirement.coc_nvim then vim.cmd('Plug \'andis-sprinkis/coc.nvim\', {\'branch\': \'release\'}') end
if vim.g.plug_requirement.markdown_preview then vim.cmd('Plug \'andis-sprinkis/markdown-preview.nvim\'') end
if vim.g.plug_requirement.suda then vim.cmd('Plug \'andis-sprinkis/suda.vim\'') end
if vim.g.plug_requirement.vim_cmake then vim.cmd('Plug \'andis-sprinkis/vim-cmake\'') end
if vim.g.plug_requirement.vim_doge then vim.cmd('Plug \'andis-sprinkis/vim-doge\'') end
if vim.g.plug_requirement.vim_gtest then vim.cmd('Plug \'andis-sprinkis/vim-gtest\'') end
if vim.g.plug_requirement.nvim_spectre then vim.cmd('Plug \'andis-sprinkis/nvim-spectre\'') end

vim.fn['plug#end']()
