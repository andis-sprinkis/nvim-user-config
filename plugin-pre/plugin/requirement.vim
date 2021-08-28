if !executable("git")
  let g:nogitplugin = 1
else
  " Allows setting a startup variable to disable loading git plugins
  " (for use cases with a slow IO e.g. remote SSHFS mounts).
  if !exists("g:nogitplugin") | let g:nogitplugin = 0 | endif
endif

let g:requirementGitPlugins = g:nogitplugin == 0
let g:requirementCocNvim = executable("node") && executable("yarn")
let g:requirementSudaVim = executable("sudo")
let g:requirementFzfInstall = g:os == "Windows" || g:os == "Darwin"
let g:requirementVimDoge = executable("node")
let g:requirementMarkdownPreviewNvim = executable("node") && executable("yarn")
let g:requirementVimCmake = executable("cmake")
let g:requirementVimGtest = executable("gtester")
