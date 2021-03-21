" Specify a directory for plugins
call plug#begin(stdpath('config').'/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'} " The best plugin in the world
Plug 'airblade/vim-gitgutter' " Show git additions/deletions in the gutter
Plug 'sheerun/vim-polyglot' " Better syntax highlighting
Plug '~/.fzf' " Use the path where fzf is installed
Plug 'junegunn/fzf.vim' " Fuzzy finder for file/buffer/window switching and search
Plug 'itchyny/lightline.vim' " A sexier status bar and colourscheme to match
Plug 'christoomey/vim-tmux-navigator' " Switch vim panes with the same commands as tmux
Plug 'honza/vim-snippets' " Snippet library!
Plug 'tpope/vim-commentary' " Comment lines like a god
Plug 'joshdick/onedark.vim' " Colours

" Initialize plugin system
call plug#end()
