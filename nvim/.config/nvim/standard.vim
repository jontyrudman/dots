filetype plugin on

" Spell check
set spelllang=en_gb
autocmd FileType markdown setlocal spell
autocmd FileType tex setlocal spell

" Change split config
set splitright
set splitbelow

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

set number
set relativenumber

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab " Spaces, not tabs, people

set mouse=a
set clipboard+=unnamedplus " Use system clipboard

set hidden

" Some LSP servers have issues with backup files
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

set updatetime=300 " Better for diagnostic messages

" don't give |ins-completion-menu| messages.
set shortmess+=c
set signcolumn=yes

" Split navigation shouldn't be a pane
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
