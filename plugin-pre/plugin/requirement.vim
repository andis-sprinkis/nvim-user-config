let g:requirementCocNvim = executable("node") && executable("yarn")
let g:requirementSudaVim = executable("sudo")
let g:requirementGitPlugins = g:nogitplugin == 0
let g:requirementFzfInstall = g:os == "Windows" || g:os == "Darwin"
let g:requirementVimDoge = executable("node")
let g:requirementMarkdownPreviewNvim = executable("node") && executable("yarn")
let g:requirementVimCmake = executable("cmake")
let g:requirementVimGtest = executable("gtester")
