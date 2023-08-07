local g = vim.g
local fn = vim.fn
local sys_reqr = g.sys_reqr

local M = {
  'iamcco/markdown-preview.nvim',
  cond = sys_reqr.markdown_preview,
  enabled = sys_reqr.markdown_preview,
  build = function() fn['mkdp#util#install']() end,
  ft = { 'markdown', 'markdown.mdx' },
  cmd = { 'MarkdownPreview', 'MarkdownPreviewToggle' }
}

return M
