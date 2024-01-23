local M = {
  'uga-rosa/cmp-dictionary',
  config = function()
    local dict = require("cmp_dictionary")

    dict.setup({
      exact = 2,
      first_case_insensitive = true,
      document = false,
      document_command = "wn %s -over",
      max_items = 3000,
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
  end,
  commit = "d17bc1f87736b6a7f058b2f246e651d34d648b47"
}

return M
