" GENERAL SETTINGS
"
let mapleader=','
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set nu
syntax on

set showmatch           " show matching braces
set title               " show terminal title
set wildmenu            " menu for tab completion
set wildmode=list:full  " list for wildcard completion

" FOLDING
"
set foldenable
set foldmethod=marker
set foldmarker={{,}}

" SEARCH
"
set ignorecase    " case insensitive search
set smartcase     " case sensitive if >= 1 upper case
set hlsearch      " highlight search result
set incsearch     " incremental search
set nolazyredraw  " don't redraw while executing macros

" BINDINGS
"
" map	normal, visual, operator pending mode
" cmap	command line mode
" imap	insert mode
" nmap	normal mode
"

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

imap jk <esc>
nmap <leader>, :w<cr>
imap <leader>q <esc>:q<cr>
nmap <leader>q :q<cr>
nmap QQ :q!<cr>

" move by visual line, don't skip fake lines
noremap j gj
noremap k gk

map <C-c> :nohl<cr><C-l>:echo "Search Cleared!"<cr>

" user-defined commands
command Wbn :w|bn		" save + next buffer
cnoreabbrev wbn Wbn

set background=dark
set t_Co=256
