local g = vim.g
local fn = vim.fn
local os = g.os
local executable = fn.executable

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  if fn.confirm("Download and initialize the configured plugins?", "&Yes\n&No", 2) == 2 then return end
  fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

g.exec = {
  bash = executable('bash') == 1,
  bat = executable('bat') == 1,
  cat = executable('cat') == 1,
  fzf = executable('fzf') == 1,
  lf = executable('lf') == 1,
  node = executable('node') == 1,
  python3 = executable('python3') == 1,
  rg = executable('rg') == 1,
  sed = executable('sed') == 1,
  sudo = executable('sudo') == 1,
  tmux = executable('tmux') == 1,
  zsh = executable('zsh') == 1,
}

local exec = g.exec

g.sys_reqr = {
  cmp_tmux = exec.tmux,
  cmp_zsh = exec.zsh,
  cmp_rg = exec.rg,
  fm_nvim = exec.lf,
  fzf_lua = os ~= 'Windows_NT' and exec.fzf,
  fzf_vim = os == 'Windows_NT' and exec.bash,
  lsp_plugins = exec.node,
  markdown_preview = exec.node,
  nvim_spectre = exec.sed,
  suda_vim = exec.sudo,
  swenv = exec.python3,
  vim_doge = exec.node,
}

require("lazy").setup(
  {
    require('plugin.bufstop'),
    require('plugin.colorscheme'),
    require('plugin.comment_nvim'),
    require('plugin.debugprint_nvim'),
    require('plugin.dirvish'),
    require('plugin.dressing_nvim'),
    require('plugin.fm_nvim'),
    require('plugin.url_open'),
    require('plugin.fzf_lua'),
    require('plugin.fzf_vim'),
    require('plugin.gitsigns_nvim'),
    require('plugin.guess_indent_nvim'),
    require('plugin.hlargs_nvim'),
    require('plugin.indent_blankline_nvim'),
    require('plugin.markdown_preview'),
    require('plugin.mason_nvim'),
    require('plugin.matchparen_nvim'),
    require('plugin.mkdir_nvim'),
    require('plugin.nvim_cmp'),
    require('plugin.nvim_colorizer'),
    require('plugin.nvim_context_vt_nvim'),
    require('plugin.nvim_dap_ui'),
    require('plugin.nvim_dap_virtual_text'),
    require('plugin.nvim_early_retirement'),
    require('plugin.nvim_pqf'),
    require('plugin.nvim_spectre'),
    require('plugin.nvim_treesitter'),
    require('plugin.registers_nvim'),
    require('plugin.smart_splits_nvim'),
    require('plugin.suda'),
    require('plugin.swenv_nvim'),
    require('plugin.treesj'),
    require('plugin.vim_doge'),
    require('plugin.vim_eunuch'),
    require('plugin.vim_fugitive'),
    require('plugin.vim_illuminate'),
    require('plugin.vim_octave'),
    require('plugin.vim_table_mode'),
    require('plugin.vim_wordmotion'),
    require('plugin.winshift_nvim'),
  },
  {
    ui = {
      icons = {
        cmd = "[cmd]",
        config = "[config]",
        event = "[event]",
        ft = "[ft]",
        init = "[init]",
        keys = "[keys]",
        plugin = "[plugin]",
        runtime = "[runtime]",
        source = "[source]",
        start = "[start]",
        task = "[task]",
        lazy = "💤 ",
      },
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip",
          "matchparen",
          "netrwPlugin",
          "rplugin",
          "spellfile",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    }
  }
)

require('statusline')
