let s:fontname = "Cascadia Code PL"
let s:fontsize = 13

function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  execute "GuiFont! " . s:fontname . ":h" . s:fontsize
endfunction

call AdjustFontSize(0)

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

" Disable GUI widgets
GuiPopupmenu 0
GuiTabline 0

" Determine OS
ru! get-os.vim

" Go to partition root when no path specified
if g:os == "Windows" && (expand("%:p")) == "" | cd / | endif
