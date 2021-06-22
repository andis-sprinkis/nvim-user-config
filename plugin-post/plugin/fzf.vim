if !g:requirementGitPlugins
  nnoremap <silent><tab> :Files<cr>
else
  function! ShowGitFiles()
    let gitDirExists = system("git rev-parse --git-dir") == ".git\n"
    if gitDirExists == 1
      execute "GFiles --exclude-standard --others --cached"
    elseif gitDirExists == 0
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
  let $FZF_DEFAULT_OPTS = "--tabstop=2 --cycle --color=dark --layout=reverse --preview 'bat --color=always --line-range=:500 {}'"
else
  let $FZF_DEFAULT_OPTS = "--tabstop=2 --cycle --color=dark --layout=reverse"
endif

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9, 'relative': 'editor', 'yoffset': 0.5 } }
