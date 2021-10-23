-- Use <c-space> to trigger completion.
vim.api.nvim_set_keymap('i', '<c-space>', 'coc#refresh()', { silent = true, noremap = true, expr = true })

-- Make <CR> auto-select the first completion item and notify coc.nvim to
-- format on enter, <cr> could be remapped by other vim plugin
vim.api.nvim_set_keymap('n', '<cr>', 'pumvisible() ? coc#_select_confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"', { silent = true, noremap = true, expr })


-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })


-- GoTo code navigation.
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Code reformatting bindings
vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(coc-format-selected)', { nowait = true })
vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(coc-format-selected)', { nowait = true })

-- Applying codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
vim.api.nvim_set_keymap('n', '<leader>a ', '<Plug>(coc-codeaction-selected)', {})
vim.api.nvim_set_keymap('x', '<leader>a ', '<Plug>(coc-codeaction-selected)', {})

-- Remap keys for applying codeAction to the current buffer.
vim.api.nvim_set_keymap('n', '<leader>ac', '<Plug>(coc-codeaction)', { nowait = true })

-- Apply AutoFix to problem on the current line.
vim.api.nvim_set_keymap('n', '<leader>qf', '<Plug>(coc-fix-current)', { nowait = true })

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vim.api.nvim_set_keymap('x', 'if', '<Plug>(coc-funcobj-i)', {})
vim.api.nvim_set_keymap('o', 'if', '<Plug>(coc-funcobj-i)', {})
vim.api.nvim_set_keymap('x', 'af', '<Plug>(coc-funcobj-a)', {})
vim.api.nvim_set_keymap('o', 'af', '<Plug>(coc-funcobj-a)', {})
vim.api.nvim_set_keymap('x', 'ic', '<Plug>(coc-classobj-i)', {})
vim.api.nvim_set_keymap('o', 'ic', '<Plug>(coc-classobj-i)', {})
vim.api.nvim_set_keymap('x', 'ac', '<Plug>(coc-classobj-a)', {})
vim.api.nvim_set_keymap('o', 'ac', '<Plug>(coc-classobj-a)', {})

-- Symbol renaming.
vim.api.nvim_set_keymap('n', '<leader>n', '<Plug>(coc-rename)', { nowait = true })

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
vim.api.nvim_set_keymap('n', '<c-s>', '<Plug>(coc-range-select)', { nowait = true, silent = true })
vim.api.nvim_set_keymap('x', '<c-s>', '<Plug>(coc-range-select)', { nowait = true, silent = true })

-- Mappings for CoCList
-- Show all diagnostics.
vim.api.nvim_set_keymap('n', '<space>d', ':<C-u>CocList diagnostics<cr>', { noremap = true, nowait = true, silent = true })
