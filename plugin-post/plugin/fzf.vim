if !g:requirementGitPlugins
  nnoremap <silent><tab> :Files<cr>
else
  function! ShowGitFiles()
    if system("git rev-parse --git-dir") == ".git\n"
      execute "GFiles --exclude-standard --others --cached"
    else
      execute "Files"
    endif
  endfunction

  nnoremap <silent><tab> :call ShowGitFiles()<cr>
endif

nnoremap <silent><s-tab> :Files<cr>
nnoremap <silent><leader>e :Rg<cr>

if executable("bat")
  let $BAT_THEME = "ansi"
  let $BAT_STYLE = "plain"
  let $FZF_DEFAULT_OPTS = "--tabstop=2 --cycle --color=dark --layout=reverse-list --preview 'bat --color=always --line-range=:500 {}' --preview-window=up,62%,wrap"
else
  let $FZF_DEFAULT_OPTS = "--tabstop=2 --cycle --color=dark --layout=reverse-list --preview-window=up,62%,wrap"
endif

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.95, 'relative': 'editor', 'yoffset': 0.5 } }
