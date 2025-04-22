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
        if (result.kind == 'refactor.move') then
          return false
        end

        return true
      end
    })
  end
}

return M
