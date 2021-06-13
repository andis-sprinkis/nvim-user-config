let g:RequirementsCocNvim = executable("node") && executable("yarn")
let g:RequirementsSudaVim = executable("sudo")
let g:RequirementsGitPlugins = g:nogit == 0 && executable("git")
let g:RequirementsFzfInstall = g:os == "Windows" || g:os == "Darwin"
let g:RequirementsVimJsdoc = executable("node")
let g:RequirementsMarkdownPreviewNvim = executable("node") && executable("yarn")
let g:RequirementsVimCmake = executable("cmake")
let g:RequirementsVimGtest = executable("gtester")
