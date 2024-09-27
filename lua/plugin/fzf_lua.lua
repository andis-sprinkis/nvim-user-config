local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'ibhagwan/fzf-lua',
  cond = sys_reqr.fzf_lua,
  enabled = sys_reqr.fzf_lua,
  config = function()
    -- local exec = g.exec
    local km = vim.keymap.set

    -- local previewer_ext_associations = {}
    -- local previewer_ext = {
    --
    -- }
    --
    -- for _, ext in pairs(previewer_ext) do
    --
    -- end

    local fzflua = require('fzf-lua')

    fzflua.setup({
      fzf_colors = {
        ["bg"]      = { "bg", "Normal" },
        ["bg+"]     = { "bg", "CursorLine" },
        ["fg"]      = { "fg", "CursorLine" },
        ["fg+"]     = { "fg", "Normal" },
        ["gutter"]  = "-1",
        ["header"]  = { "fg", "Comment" },
        ["hl"]      = { "fg", "Comment" },
        ["hl+"]     = { "fg", "Statement" },
        ["info"]    = { "fg", "PreProc" },
        ["marker"]  = { "fg", "Keyword" },
        ["pointer"] = { "fg", "Exception" },
        ["prompt"]  = { "fg", "Conditional" },
        ["spinner"] = { "fg", "Label" },
      },
      previewers = {
        cat = {
          cmd = 'cat',
          args = '--number',
        },
        bat = {
          cmd = 'bat',
          args = '--style=plain,numbers,header-filename,changes --color=always',
          theme = 'Visual Studio Dark+',
        },
        man = {
          cmd = 'man %s | col -bx',
        },
        builtin = {
          extensions      =  sys_reqr.previewer and {
            -- TODO: table with all extensions
            ["jpg"]       = { "previewer", "{file}" },
            ["jpeg"]       = { "previewer", "{file}" },
            ["png"]       = { "previewer", "{file}" },
            ["gif"]       = { "previewer", "{file}" },
            ["webp"]       = { "previewer", "{file}" },
            ["pdf"]       = { "previewer", "{file}" },
            ["mp4"]       = { "previewer", "{file}" },
            ["mov"]       = { "previewer", "{file}" },
            ["mkv"]       = { "previewer", "{file}" },
          } or {},
        }
      },
      defaults = {
        git_icons = false,
        file_icons = false
      },
      winopts = {
        fullscreen = true,
        border = 'none',
        preview = {
          -- default = (exec.bat and 'bat') or (exec.cat and 'cat') or 'builtin',
          wrap = 'wrap',
          layout = 'vertical',
          vertical = 'up:60%',
          border = 'noborder',
          scrollchars = {'│', '' },
          delay = 50,
        },
        hl = {
          border = 'FloatBorder'
        }
      }
    })

    local function show_files_with_git()
      if vim.fn.system('git rev-parse --git-dir') == '.git\n' then
        fzflua.git_files({ resume = true })
        return
      end

      fzflua.files({ resume = true })
    end

    km(
      'n',
      '<tab>',
      show_files_with_git,
      { desc = 'Search file paths in the working directory (Git or all) (fzf-lua)' }
    )

    km(
      'n',
      '<s-tab>',
      function() fzflua.files({ resume = true }) end,
      { desc = 'Search file paths in the working directory (all) (fzf-lua)' }
    )

    km(
      'n',
      '<leader>e',
      function() fzflua.grep({ search = '', resume = true }) end,
      { desc = 'Search text in files in the working directory (Git or all) (fzf-lua)' }
    )

    km(
      'n',
      '<leader>z',
      function() fzflua.builtin({ resume = true }) end,
      { desc = 'Search fzf-lua builtin commands (fzf-lua)' }
    )

    km(
      'n',
      '<leader>h',
      function() fzflua.help_tags({ resume = true }) end,
      { desc = 'Search Help tags (fzf-lua)' }
    )
  end,
  event = { "CmdlineEnter" },
  keys = {
    { "<tab>",     mode = { "n" } },
    { "<s-tab>",   mode = { "n" } },
    { "<leader>e", mode = { "n" } },
    { "<leader>z", mode = { "n" } },
    { "<leader>h", mode = { "n" } },
  },
  dependencies = {
    'stevearc/dressing.nvim',
  },
}

return M
