vim.g.nogitplugin = (vim.fn.executable('git') == false) or vim.g.nogitplugin == true

vim.g.sys_reqr = {
  dap_plugins = vim.g.os ~= 'Windows',
  fm_nvim = vim.fn.executable('lf') == 1,
  fzf = vim.g.os == 'Windows' or vim.g.os == 'Darwin',
  fzf_lua = vim.g.os ~= 'Windows',
  fzf_vim = vim.g.os == 'Windows' and (vim.fn.executable('bash') == 1),
  git_plugins = vim.g.nogitplugin == false,
  lsp_plugins = vim.fn.executable('node') == 1,
  markdown_preview = vim.fn.executable('node') == 1,
  nvim_spectre = vim.fn.executable('sed') == 1,
  suda_vim = vim.fn.executable('sudo') == 1,
  treesitter = vim.fn.executable('tree-sitter') == 1,
  vim_doge = vim.fn.executable('node') == 1,
  vim_hexokinase = vim.fn.executable('go') == 1,
}

local packer_bootstrap
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use {
    {
      'lewis6991/impatient.nvim',
      config = function() require('impatient') end,
    },
    { 'wbthomason/packer.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'Jorengarenar/vim-MvVis' },
    { 'markonm/traces.vim' },
    { 'RRethy/vim-illuminate' },
    { 'antoinemadec/FixCursorHold.nvim' },
    { 'chaoren/vim-wordmotion' },
    { 'dhruvasagar/vim-table-mode' },
    { 'editorconfig/editorconfig-vim' },
    { 'tpope/vim-eunuch' },
    { 'tversteeg/registers.nvim' },
    { 'haringsrob/nvim_context_vt' },
    {
      'sindrets/winshift.nvim',
      config = function() require('plugin_post.winshift_nvim') end,
    },
    {
      cond = { vim.g.sys_reqr['git_plugins'] },
      { 'tpope/vim-fugitive' },
      {
        'lewis6991/gitsigns.nvim',
        config = function() require('plugin_post.gitsigns_nvim') end,
      },
    },
    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      cond = { vim.g.sys_reqr['treesitter'] },
      config = function() require('plugin_post.nvim_treesitter') end,
      requires = {
        { 'JoosepAlviste/nvim-ts-context-commentstring' },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
      }
    },
    {
      'williamboman/nvim-lsp-installer',
      cond = { vim.g.sys_reqr['lsp_plugins'] },
      config = function()
        require('plugin_post.nvim_lsp_installer')
        require('plugin_post.null_ls_nvim')
      end,
      requires = {
        { 'b0o/schemastore.nvim' },
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'neovim/nvim-lspconfig' },
      },
    },
    {
      cond = vim.g.sys_reqr['dap_plugins'],
      { 'Pocco81/DAPInstall.nvim' },
      { 'mfussenegger/nvim-dap' },
      { 'theHamsta/nvim-dap-virtual-text' },
    },
    {
      'junegunn/fzf',
      cond = { vim.g.sys_reqr['fzf'] },
      run = function() vim.fn['fzf#install']() end,
    },
    {
      'ibhagwan/fzf-lua',
      cond = { vim.g.sys_reqr['fzf_lua'] },
      config = function() require('plugin_post.fzf_lua') end
    },
    {
      'junegunn/fzf.vim',
      cond = { vim.g.sys_reqr['fzf_vim'] },
      config = function() require('plugin_post.fzf_vim') end
    },
    {
      'is0n/fm-nvim',
      cond = { vim.g.sys_reqr['fm_nvim'] },
      config = function() require('plugin_post.fm_nvim') end,
    },
    {
      'nvim-pack/nvim-spectre',
      cond = { vim.g.sys_reqr['nvim_spectre'] },
      config = function() require('plugin_post.nvim_spectre') end,
    },
    {
      'lambdalisue/suda.vim',
      cond = { vim.g.sys_reqr['suda_vim'] },
      config = function() require('plugin_post.suda') end,
    },
    {
      'kkoomen/vim-doge',
      run = function() vim.fn['doge#install']() end,
      cond = { vim.g.sys_reqr['vim_doge'] },
    },
    {
      'rrethy/vim-hexokinase',
      run = 'make hexokinase',
      cond = { vim.g.sys_reqr['vim_hexokinase'] },
    },
    {
      cond = { vim.g.sys_reqr['markdown_preview'] },
      'iamcco/markdown-preview.nvim',
      run = function () vim.fn['mkdp#util#install']() end,
      ft = { 'markdown', 'vim-plug' },
    },
    {
      'AndrewRadev/splitjoin.vim',
      config = function() require('plugin_post.splitjoin') end
    },
    {
      'Mofiqul/vscode.nvim',
      config = function() require('plugin_post.colorscheme') end,
    },
    {
      'NMAC427/guess-indent.nvim',
      config = function() require('plugin_post.guess_indent_nvim') end,
    },
    {
      'notomo/cmdbuf.nvim',
      config = function() require('plugin_post.cmdbuf_nvim') end,
    },
    {
      'hrsh7th/nvim-cmp',
      requires = {
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'David-Kunz/cmp-npm' },
        { 'petertriho/cmp-git' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-emoji' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path' },
      },
      config = function() require('plugin_post.nvim_cmp') end
    },
    {
      'justinmk/vim-dirvish',
      config = function() require('plugin_post.dirvish') end
    },
    {
      'lukas-reineke/indent-blankline.nvim',
      config = function() require('plugin_post.indent_blankline_nvim') end
    },
    {
      'mihaifm/bufstop',
      config = function() require('plugin_post.bufstop') end
    },
    {
      'numToStr/Comment.nvim',
      config = function() require('plugin_post.comment_nvim') end
    },
  }

  if packer_bootstrap then require('packer').sync() end
end)

if vim.g.sys_reqr['git_plugins'] and vim.g.sys_reqr['lsp_plugins'] then require('plugin_post.statusline') end
