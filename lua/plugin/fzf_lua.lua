local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'ibhagwan/fzf-lua',
  cond = sys_reqr.fzf_lua,
  enabled = sys_reqr.fzf_lua,
  config = function()
    local exec = g.exec
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
        ["fg"]      = { "fg", "CursorLine" },
        ["bg"]      = { "bg", "Normal" },
        ["hl"]      = { "fg", "Comment" },
        ["fg+"]     = { "fg", "Normal" },
        ["bg+"]     = { "bg", "CursorLine" },
        ["hl+"]     = { "fg", "Statement" },
        ["info"]    = { "fg", "PreProc" },
        ["prompt"]  = { "fg", "Conditional" },
        ["pointer"] = { "fg", "Exception" },
        ["marker"]  = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"]  = { "fg", "Comment" },
        ["gutter"]  = "-1",
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
        },
        hl = {
          border = 'FloatBorder'
        }
      }
    })

    local function show_files_with_git()
      if vim.fn.system('git rev-parse --git-dir') == '.git\n' then
        fzflua.git_files()
        return
      end

      fzflua.files()
    end

    km('n', '<tab>', show_files_with_git, { desc = 'Search file paths in the working directory (Git or all) (fzf-lua)' })
    km('n', '<s-tab>', fzflua.files, { desc = 'Search file paths in the working directory (all) (fzf-lua)' })
    km('n', '<leader>e', function() fzflua.grep({ search = '' }) end, { desc = 'Search text in files in the working directory (Git or all) (fzf-lua)' })
    km('n', '<leader>z', fzflua.builtin, { desc = 'Search fzf-lua builtin commands (fzf-lua)' })
    km('n', '<leader>h', fzflua.help_tags, { desc = 'Search Help tags (fzf-lua)' })
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
