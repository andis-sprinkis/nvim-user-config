local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'https://github.com/ibhagwan/fzf-lua',
  enabled = sys_reqr.fzf_lua,
  config = function()
    local km = vim.keymap.set

    local fzflua = require('fzf-lua')

    fzflua.awesome_colorschemes = nil
    fzflua.zoxide = nil

    fzflua.register_ui_select()

    local args_previewer = { "previewer", "{file}" }
    local extensions_previewer = {
      ["jpg"]  = args_previewer,
      ["jpeg"] = args_previewer,
      ["png"]  = args_previewer,
      ["gif"]  = args_previewer,
      ["avif"] = args_previewer,
      ["webp"] = args_previewer,
      ["svg"]  = args_previewer,
      ["ico"]  = args_previewer,
      ["pdf"]  = args_previewer,
      ["avi"]  = args_previewer,
      ["mkv"]  = args_previewer,
      ["mpg"]  = args_previewer,
      ["mpeg"] = args_previewer,
      ["mov"]  = args_previewer,
      ["mp4"]  = args_previewer,
      ["zip"]  = args_previewer,
      ["rar"]  = args_previewer,
      ["tar"]  = args_previewer,
      ["gz"]   = args_previewer,
    }
    -- TODO: table with all extensions extracted from mimedb

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
        man = {
          cmd = 'man %s | col -bx',
        },
        builtin = {
          extensions = extensions_previewer,
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
          title = true,
          wrap = 'wrap',
          layout = 'vertical',
          vertical = 'up:60%',
          scrollbar = false,
          border = 'border-top',
          delay = 15,
        }
      }
    })

    local function show_files_with_git()
      if vim.fn.system({ 'git', 'rev-parse', '--git-dir' }) == '.git\n' then
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
      '<leader>Z',
      function() fzflua.helptags() end,
      { desc = 'Search help tags (fzf-lua)' }
    )

    km(
      'n',
      '<leader>z',
      function() fzflua.builtin({ resume = true }) end,
      { desc = 'Search fzf-lua builtin commands (fzf-lua)' }
    )
  end,
  event = 'VeryLazy',
}

return M
