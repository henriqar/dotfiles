""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mantainer: henriqar
"
" Version: 1.0
"
" Sections:
"
"   -> Vim-Plug Installation
"   -> Folding Info
"   -> Folding Created Subsections:
"
"       * Colors
"       * Misc
"       * Spaces and Tabs
"       * UI Layout
"       * Searching
"       * Autogroups
"       * Backup
"       * Custom Functions
"       * Vim Plug Input:
"
"           - Plugin: Lightline
"           - Plugin: Commentary
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimPlug Installation:
"
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" ~on vim~ this command will download and install all plugins:
" $ :PlugInstall
"
" ref: https://github.com/junegunn/vim-plug
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding Info:
"
" 	-> foldmethod=marker - fold sections by markers, rather than indentation
"	-> foldlevel=0		 - close every fold by default
" 	-> set modelines=1   -  make Vim only use these settings for this fil
"
"   ---------------------------------------
"   To use folding:
"
"   zi   :   toogle all folding open/close
"   za   :   toogle current fold open/close
"   zc   :   close current fold
"   zR   :   open all folds
"   zM   :   close all folds
"   zv   :   expand folds to reveal cursor
"   ---------------------------------------
"
" ref: https://dougblack.io/words/a-good-vimrc.html                   
"

" Set moeline for vims that are not compiled with the modeline option
set modeline

" Colors {{{

syntax enable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  color theme
"

colorscheme desert

" }}}

" Misc {{{

set backspace=indent,eol,start

filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mouse support
set ttyfast
set mouse=a

" Set no bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remappings
:imap ;; <ESC>

" }}}

" Spaces and Tabs {{{

" set tabstop=4		" 4 space tab
set expandtab		" changes tabs for spaces
" set softtabstop=4	" 4 space tab
" set shiftwidth=4
set autoindent

autocmd Filetype cpp setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" }}}

" UI Layout {{{

set number		" line number
set showcmd		" show command on bottom bar

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split config
set splitbelow
set splitright

" }}}

" Searching {{{

set incsearch       " search as characters are entered
set showmatch       " show mathcing in text

" }}}

" Autogroups {{{

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clear trailing white spaces when saving
"
" ref: http://vim.wikia.com/wiki/Remove_unwanted_spaces#Automatically_removing_all_trailing_whitespace
"
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.sv :%s/\s\+$//e
autocmd BufWritePre *.v :%s/\s\+$//e

autocmd BufNewFile,BufRead *.u setfiletype uwu

" }}}

" Backup {{{

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" }}}

" Custom Functions {{{

" toggle between number and relativenumber
" use: :call ToggleNumber()
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" }}}

" Vim Plug {{{

call plug#begin('~/.vim/plugged')

    " Commentary plugin
    Plug 'tpope/vim-commentary'

    " Vim Fugitive
    Plug 'tpope/vim-fugitive'

    " Vim surroundings
    Plug 'tpope/vim-surround'

    " Lightline plugin
    Plug 'itchyny/lightline.vim'

call plug#end()

" }}}

" Plugin: Lightline {{{

" to show airline colors
set laststatus=2

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" }}}

" Plugin: Netrw {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Tree
"
" set netrw windows size as 25%
let g:netrw_winsize = 25

"set list style
let g:netrw_liststyle = 3

" remove banner from netrw window
let g:netrw_banner = 0        

" open files in previous window
let g:netrw_browse_split = 4  

augroup ProjectDrawer
        autocmd!
        autocmd VimEnter * :Vexplore
augroup END

" }}}

" Plugin: Commentary {{{

" Use the command below to insert not known commentary for file type
"autocmd FileType apache setlocal commentstring=#\ %s

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" need to be here for folding to work
" vim:foldmethod=marker:foldlevel=0
