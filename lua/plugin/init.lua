local fn = vim.fn
local g = vim.g
-- local os = g.os
local executable = fn.executable

g.exec = {
  bash = executable('bash') == 1,
  bat = executable('bat') == 1,
  cat = executable('cat') == 1,
  chafa = executable('chafa') == 1,
  fzf = executable('fzf') == 1,
  node = executable('node') == 1,
  previewer = executable('previewer') == 1,
  python3 = executable('python3') == 1,
  rg = executable('rg') == 1,
  rust = executable('rust') == 1,
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
  fzf_lua = exec.fzf,
  -- fzf_lua = os ~= 'Windows_NT' and exec.fzf,
  -- fzf_vim = os == 'Windows_NT' and exec.bash,
  previewer = os ~= 'Windows_NT' and exec.previewer,
  lsp_asm = exec.rust,
  lsp_neocmake = exec.rust,
  lsp_plugins = exec.node,
  markdown_preview = exec.node,
  nvim_spectre = exec.sed,
  suda_vim = exec.sudo,
  swenv = exec.python3,
  vim_doge = exec.node,
}

local M = {
  require('plugin.bufstop'),
  require('plugin.colorscheme'),
  require('plugin.comment_nvim'),
  require('plugin.dirvish'),
  require('plugin.fix_auto_scroll_nvim'),
  require('plugin.fzf_lua'),
  require('plugin.garbageday_nvim'),
  require('plugin.gitsigns_nvim'),
  require('plugin.guess_indent_nvim'),
  require('plugin.hlargs_nvim'),
  require('plugin.indent_blankline_nvim'),
  require('plugin.lf_vim'),
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
  require('plugin.nvim_ts_commentstring'),
  require('plugin.registers_nvim'),
  require('plugin.smart_splits_nvim'),
  require('plugin.suda_vim'),
  require('plugin.swenv_nvim'),
  require('plugin.treesj'),
  require('plugin.typst_preview_nvim'),
  require('plugin.vim_color_convert_to'),
  require('plugin.vim_doge'),
  require('plugin.vim_eunuch'),
  require('plugin.vim_fugitive'),
  require('plugin.vim_illuminate'),
  require('plugin.vim_octave'),
  require('plugin.vim_table_mode'),
  require('plugin.vim_wordmotion'),
  require('plugin.which_key_nvim'),
  require('plugin.winshift_nvim'),
}

return M
