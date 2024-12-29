local api = vim.api
local fn = vim.fn

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  if fn.confirm("Download and initialize the configured plugins?", "&Yes\n&No", 2) == 2 then
    return
  end

  local out = fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })

  if vim.v.shell_error ~= 0 then
    api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  require('plugin'),
  {
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
  }
)
