local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'https://github.com/iamcco/markdown-preview.nvim',
  branch = 'master',
  commit = 'a923f5fc5ba36a3b17e289dc35dc17f66d0548ee',
  enabled = sys_reqr.markdown_preview,
  config = function ()
    vim.g.mkdp_page_title = '${name} (Markdown preview)'
  end,
  build = function() vim.fn["mkdp#util#install"]() end,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { 'markdown' },
}

return M
