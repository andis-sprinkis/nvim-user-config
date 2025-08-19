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
  bat = executable('bat') == 1,
  curl = executable('curl') == 1,
  fzf = executable('fzf') == 1,
  lf = executable('lf') == 1,
  node = executable('node') == 1,
  previewer = executable('previewer') == 1,
  python3 = executable('python3') == 1,
  rg = executable('rg') == 1,
  rust = executable('rust') == 1,
  tmux = executable('tmux') == 1,
}

local exec = g.exec

g.sys_reqr = {
  cmp_tmux = exec.tmux,
  cmp_rg = exec.rg,
  fzf_lua = exec.fzf,
  previewer = exec.previewer,
  lsp_asm = exec.rust,
  lsp_neocmake = exec.rust,
  lsp_plugins = exec.node,
  markdown_preview = exec.node,
  swenv = exec.python3,
  vim_doge = exec.node,
  typst_preview_nvim = exec.curl,
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
