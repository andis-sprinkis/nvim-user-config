local M = {
  'kosayoda/nvim-lightbulb',
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
      ignore = {
        clients = { "null-ls" },
      },
      ---@type (fun(client_name:string, result:lsp.CodeAction|lsp.Command):boolean)|nil
      filter = function (client, result)
        if (client == 'ts_ls') then
          --
        end
        return true
      end
    })
  end
}

return M
