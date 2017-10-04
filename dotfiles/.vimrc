set nocompatible
filetype off
syntax enable
" -------------------------------
" PLUGIN MANAGEMENT
" -------------------------------

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'groenewege/vim-less'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'othree/html5.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'bling/vim-airline'
Plugin 'joshdick/onedark.vim'
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on

au BufReadPost *.vue set syntax=vue

" ------------------------------
"  GENERAL CONFIGURATIO
" -----------------------------

" Set to auto read when a file is changed from the outside
set autoread

" Always show current position
set ruler
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets
set showmatch

" Remove trailing white space
autocmd BufWritePre *.py :%s/\s\+$//e

" Ignore System & Compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Disable Silly backup files
set nobackup
set nowb
set noswapfile

" -------------------------------
"  TEXT CONFIGURATION
" ------------------------------
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set nowrap
set textwidth=0
set splitright
set ai
set si
set number

" ------------------------------
" COLOR SCHEMES
" -----------------------------
set laststatus=2
set background=dark
set t_Co=256
let g:molokai_original = 1
colorscheme molokai

let g:airline_theme = 'molokai'
