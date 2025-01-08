local g = vim.g
local api = vim.api
local fn = vim.fn
local executable = fn.executable

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  if fn.confirm("Download and initialize the configured plugins?", "&Yes\n&No", 2) == 2 then
    return
  end

  local out = fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

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

require("lazy").setup({
  spec = {
    { import = "plugin" },
  },
  ui = {
    icons = {
      cmd = "[Cmd]",
      config = "[Config]",
      event = "[Event]",
      ft = "[Ft]",
      init = "[Init]",
      keys = "[Keys]",
      plugin = "[Plugin]",
      runtime = "[Runtime]",
      source = "[Source]",
      start = "[Start]",
      task = "[Task]",
      lazy = "💤 ",
      favorite = "[Favorite]",
      import = "[Import] ",
      loaded = "[Loaded]",
      not_loaded = "[Not loaded]",
      require = "[Require] ",
      list = {
        "-",
      },
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
})
