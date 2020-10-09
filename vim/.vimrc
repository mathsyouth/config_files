" URL: https://github.com/mathsyouth/dotfiles/
" Author: Linghui Zeng
" Description: Personal .vimrc file,
"     stolen from https://github.com/ruslanosipov/dotfiles/blob/master/vimrc
"
" All the plugins are managed via Vundle
"
"
" => Pre-load ------------------------------------------------------------- {{{1

" 不与 Vi 兼容
set nocompatible              " be iMproved, required
filetype off                  " required

" => Vundle plugins ------------------------------------------------------- {{{1

" Vundle, the plug-in manager for Vim
" https://github.com/VundleVim/Vundle.vim
" set up Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" configure Plugins
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Pairs of handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Plugin 'ctrlpvim/ctrlp.vim'
" A command-line fuzzy finder
Plugin 'junegunn/fzf.vim'
" A code-searching tool similar to ack, but faster
" Vim plugin for the Perl module / CLI script 'ack'
Plugin 'mileszs/ack.vim'
" Before installing taglist, install ctags first
" https://github.com/universal-ctags/ctags

" Lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" colorscheme
Plugin 'chriskempson/base16-vim'

" fugitive.vim: A Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'

" Displays available keybindings in popup 
Plugin 'liuchengxu/vim-which-key'

" The plugin provides mappings to easily delete, change and add such
" surroundings in pairs.
Plugin 'tpope/vim-surround'

" JavaScript bundle for vim
Plugin 'pangloss/vim-javascript'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" => Plugins configuration ------------------------------------------------ {{{1

" enable fzf inside vim
" If installed using Homebrew
set rtp+=/usr/local/opt/fzf

" use Ag with ack.vim
let g:ackprg = 'ag --vimgrep'

" Provides a theme to be used in conjunction with vim-airline 
let g:airline_theme='onedark'

" => Sane defaults (from Neovim) ------------------------------------------ {{{1

if !has('nvim')
  syntax on

  " Respect indentation when starting a new line.
  set autoindent
  set autoread
  set backspace=indent,eol,start
  set belloff=all
  set complete-=i

  " Prettier display of long lines of text
  set display=lastline
  set formatoptions=tcqj
  set history=10000
  " Make Vim dynamically move you to the first match as soon as you type
  set incsearch
  " Always display a status line (it gets hidden sometimes otherwise)
  set laststatus=2
  set ruler
  set sessionoptions-=options
  " Show last command in the status line
  set showcmd
  set sidescroll=1
  set smarttab
  set ttimeoutlen=50
  set ttyfast
  set viminfo+=!
  " Display all matching files when we tab
  set wildmenu
endif

" => Editing -------------------------------------------------------------- {{{1

" Indentation without hard tabs
set expandtab
" Number of spaces to use for autoindent
set shiftwidth=4
set softtabstop=4

" File type based indentation
filetype plugin indent on 
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" CSS (tab width 2 chr, wrap at 79th char)
autocmd FileType css set sw=2
autocmd FileType css set ts=2
autocmd FileType css set sts=2
autocmd FileType css set textwidth=79
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Map the leader key to a spacebar
let mapleader = "\<space>"

" Complete till longest string, then open the wildmenu.
set wildmode=list:longest,full

" Immediately add a closing quotes or braces in insert mode
" inoremap ( ()<esc>i
" inoremap { {}<esc>i

" 多窗口编辑时, 临时放大某个窗口, 编辑完再切回原来的布局
" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" => Looks ---------------------------------------------------------------- {{{1

set t_Co=256

set background=dark
colorscheme base16-default-dark

" Highlight cursor line
set cursorline
" Default Colors for CursorLine
highlight CursorLine ctermbg=172 ctermfg=None
" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=152 ctermfg=Red
" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=172 ctermfg=None

" Display line numbers if terminal is wide enough
if &co > 80
  set nu
  set rnu
endif
" Configure Line Number Coloring
highlight LineNr ctermbg=015

" Soft word wrap
set linebreak
" Make soft line breaks much better looking
set breakindent
" append '>>' to indent
set showbreak=>>

" highlight multiple columns
set colorcolumn=80,100
highlight ColorColumn ctermbg=007

" 光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set showmatch

" 在底部显示，当前处于命令模式还是插入模式
set showmode

" 如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块
set listchars=trail:■

" enable folding
set foldenable
" indentation folding
set foldmethod=indent
" display a column along the left-hand side of the screen with information
" about the folds in the current file. It indicates whether the corresponding
" line is an open or closed fold
set foldcolumn=2
hi FoldColumn ctermbg=016
" Set a custom color to folded highlighting
hi Folded ctermbg=007

" Tweaks for browsing
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view


" => Movement and search -------------------------------------------------- {{{1

" Ignore case when searching.
set ignorecase
set smartcase

" Fast split navigation with <Ctrl> + hjkl. 
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
tnoremap <c-j> <c-w><c-j>
tnoremap <c-k> <c-w><c-k>
tnoremap <c-l> <c-w><c-l>
tnoremap <c-h> <c-w><c-h>

" Look for a tags file recursively in parent directories
set tags=tags;

" Regenerate tags when saving Python, C, C++ files
" autocmd BufWritePost *.py *.cpp *.h silent! !ctags -R &

" highlight all search matches
set hlsearch

" Show count number of matches
set shortmess-=S

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" => Leader shortcuts ----------------------------------------------------- {{{1

" Remap CtrlP actions to be prefixed by a leader key
noremap <leader>p :CtrlP<cr>
noremap <leader>b :CtrlPBuffer<cr>
noremap <leader>m :CtrlPMRU<cr>

" Run the :Ack command on a word under cursor
nnoremap <leader>a :Ack! <c-r><c-w><cr>

" => Misc ----------------------------------------------------------------- {{{1

" 使用 utf-8 编码
set encoding=utf-8
