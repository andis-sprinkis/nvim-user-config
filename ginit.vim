let s:fontsize = 13
execute "GuiFont! Cascadia Code PL:h" . s:fontsize
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  execute "GuiFont! Cascadia Code PL:h" . s:fontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

GuiPopupmenu 0
GuiTabline 0

" Determine OS
ru! get-os.vim

" go to partition root when no path specified
if g:os == "Windows" && (expand("%:p")) == ""
  cd /
endif
