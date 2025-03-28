local M = {
  'saghen/blink.cmp',
  enabled = false,
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    -- keymap = { preset = 'default' },
    keymap = { preset = 'default' },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },
      ghost_text = {
        enabled = true,
        -- Show the ghost text when an item has been selected
        show_with_selection = true,
        -- Show the ghost text when no item has been selected, defaulting to the first item
        show_without_selection = false,
        -- Show the ghost text when the menu is open
        show_with_menu = true,
        -- Show the ghost text when the menu is closed
        show_without_menu = true,
      },
      menu = {
        draw = {
          columns = {
            { "label",       "label_description", gap = 1 },
            { "source_name", gap = 1 },
            { "kind",        gap = 1 }
          },
        }
      }
    },

    snippets = { preset = 'luasnip' },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'buffer',
      },
    },

    signature = { enabled = true },
    fuzzy = { implementation = "lua" },
  },
  opts_extend = { "sources.default" },
  dependencies = {
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  },
}

return M
