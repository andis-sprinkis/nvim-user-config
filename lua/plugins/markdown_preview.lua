local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'iamcco/markdown-preview.nvim',
  enabled = sys_reqr.markdown_preview,
  config = function ()
    vim.g.mkdp_page_title = '${name} (Markdown preview)'
  end,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { 'markdown', 'markdown.mdx' },
}

return M
