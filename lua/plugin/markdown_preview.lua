local g = vim.g
local sys_reqr = g.sys_reqr

local M = {
  'iamcco/markdown-preview.nvim',
  cond = sys_reqr.markdown_preview,
  enabled = sys_reqr.markdown_preview,
  build = function() vim.fn["mkdp#util#install"]() end,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { 'markdown', 'markdown.mdx' },
}

return M
