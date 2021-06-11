if g:nogit == 1
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
let $FZF_DEFAULT_OPTS = "--tabstop=4 --cycle --no-color --layout=reverse"
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
