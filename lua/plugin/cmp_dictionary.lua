local M = {
  'uga-rosa/cmp-dictionary',
  config = function()
    local dict = require("cmp_dictionary")

    dict.setup({
      exact = 2,
      first_case_insensitive = true,
      document = false,
      document_command = "wn %s -over",
      async = false,
      sqlite = vim.g.exec.sqlite,
      max_items = 500,
      capacity = 5,
      debug = false,
    })

    dict.switcher({
      spelllang = {
        en = {
          "~/.local/share/dict/aspell_en/aspell_en.dict",
          "~/.local/share/dict/aspell_lv/aspell_lv_no_conjugations.dict",
        }
      },
    })
  end
}

return M