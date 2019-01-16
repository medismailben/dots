syntax on

set showcmd
set hlsearch
set autoindent
set number
set mouse=a
set colorcolumn=74
"set sw=2
"set ts=2
"set sts=2
set noet

set backspace=indent,eol,start
set list listchars=tab:..,trail:_

set foldmethod=syntax
set foldlevel=20
set wildignore +=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.lo,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pdf,*.bak,*.beam


set path+=**
set wildmenu

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view

map <C-K> :pyf ~/.confs/clang-format.py<cr>
imap <C-K> <c-o>:pyf ~/.confs/clang-format.py<cr>


set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()

" Plugins

Plugin 'VundleVim/Vundle.vim'
Plugin 'DoxygenToolkit.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'mhartington/oceanic-next'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'keith/swift.vim'
Plugin 'ykaiser/hept.vim'

call vundle#end()

filetype plugin indent on
colorscheme OceanicNext
