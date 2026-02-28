local M = {
  'https://github.com/tpope/vim-fugitive',
  config = function()
    local cmd_alias = {
      Gc = 'G commit',
      Gcm = 'G commit -m',
      Gca = 'G commit --amend',
      Gcan = 'G commit --amend --no-edit',
      Gd = 'G diff',
      Gl = 'G log',
      Gpl = 'G pull',
      Gps = 'G push',
      Gs = 'G status',
      Gt = 'G checkout',
    }

    for alias, fcmd in pairs(cmd_alias) do
      vim.keymap.set(
        'ca',
        alias,
        function() return (vim.fn.getcmdtype() == ':' and vim.fn.getcmdline() == alias) and fcmd or alias end,
        { expr = true }
      )
    end
  end,
  event = { "CmdlineEnter" }
}

return M
