let g:onedark_terminal_italics = 1
let g:onedark_hide_endofbuffer = 1
colorscheme onedark

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" lightline
set noshowmode
let g:lightline = {}
let g:lightline.colorscheme = 'onedark'
