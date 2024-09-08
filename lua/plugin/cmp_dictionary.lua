local M = {
  'uga-rosa/cmp-dictionary',
  config = function()
    require("cmp_dictionary").setup({
      exact_length = 2, -- exact_length must match cmp sources entry keyword_length
      first_case_insensitive = true,
      document = {
        enable = false,
        command = { "wn", "${label}", "-over" },
      },
      max_number_items = 3000,
      debug = false,
      paths = {
        "~/.local/share/dict/aspell_en/aspell_en.dict",
        "~/.local/share/dict/aspell_lv/aspell_lv_no_conjugations.dict",
      }
    })
  end,
}

return M
