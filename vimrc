set nocompatible    " Disable vi retro-compatibility

" ---------------------------------------------------------------------------- "
" Plugins                                                                      "
" ---------------------------------------------------------------------------- "

call plug#begin('~/.vim/plugged')

Plug 'mhartington/oceanic-next'

Plug 'prabirshrestha/async.vim'       " Asynchronous
Plug 'prabirshrestha/vim-lsp'         " LSP server
Plug 'ajh17/vimcompletesme'

Plug 'Chiel92/vim-autoformat'         " Code formatter integration
Plug 'Xuyuanp/nerdtree-git-plugin'    " Versioning status
Plug 'airblade/vim-gitgutter'         " Git changes in the Sign column
Plug 'zivyangll/git-blame.vim'        " Git blame on the status bar
Plug 'tpope/vim-fugitive'             " Git wrapper
Plug 'ciaranm/detectindent'           " Indent according to the current file
Plug 'itchyny/lightline.vim'          " Lightweight powerline
Plug 'jiangmiao/auto-pairs'           " Brackets, parentheses, quotes completion
Plug 'junegunn/fzf',                  { 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'               " Command-line fuzzy finder
Plug 'majutsushi/tagbar'              " Files ctags on a sidebar
Plug 'mbbill/undotree'                " Undo history
Plug 'moll/vim-bbye'                  " Close all files without quitting vim
Plug 'scrooloose/nerdtree'            " Tree explorer
Plug 'sheerun/vim-polyglot'           " Lazy loading language pack
Plug 'tpope/vim-commentary'           " Comment shortcut
Plug 'xolox/vim-misc'                 " Miscellaneous vim scripts
Plug 'xolox/vim-session'              " Session manager
Plug 'yuttie/comfortable-motion.vim'  " Physics-based scolling
Plug 'pboettch/vim-cmake-syntax'      " CMake syntax highlight
Plug 'tmhedberg/SimpylFold'           " Python code folding

Plug 'vim-scripts/DoxygenToolkit.vim' " Doxygen style comments
Plug 'vim-scripts/errormarker.vim'    " Show compile error in-place

Plug 'JDevlieghere/llvm.vim'          " LLVM specific settings

call plug#end()

" ---------------------------------------------------------------------------- "
" Colors                                                                       "
" ---------------------------------------------------------------------------- "

try
  colorscheme OceanicNext
catch
endtry

set t_Co=256
set background=dark

highlight Normal                guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
highlight EndOfBuffer           guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
highlight LineNr                guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
highlight SignColumn            guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE

highlight GitGutterAdd          guibg=NONE ctermbg=NONE
highlight GitGutterChange       guibg=NONE ctermbg=NONE
highlight GitGutterChangeDelete guibg=NONE ctermbg=NONE
highlight GitGutterDelete       guibg=NONE ctermbg=NONE

if has("gui_running")
    "set guifont=Source\ Code\ Pro\ Medium:h13
    set antialias
end

" ---------------------------------------------------------------------------- "
" General Settings                                                             "
" ---------------------------------------------------------------------------- "

set autoread                    " Auto reload file after external command
set backspace=indent,eol,start  " Delete over line breaks
set binary                      " Enable binary support
set colorcolumn=80,120          " Show ruler columns
set encoding=utf-8              " Use UTF-8 encoding
set hidden                      " Hide buffers instead of closing them
set laststatus=2                " Always display the status line
set lazyredraw                  " Use lazy redrawing
set noshowmode                  " Don't show mode
set number                      " Show line numbers
set pastetoggle=<F2>            " Toggle paste mode with F2
set ruler                       " Show ruler
set showcmd                     " Show current command
set showmatch                   " Show matching bracket/parenthesis/etc
set showmode                    " Show current mode
set tags=tags;                  " Find tags recursively
set title                       " Change terminal title
set ttyfast                     " Fast terminal
set wildmenu                    " Visual autocomplete for command menu
set clipboard^=unnamed,unnamedplus
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set list listchars=tab:..,trail:_
set foldmethod=syntax
set foldlevel=20

" Temp Files
set nobackup                    " No backup file
set noswapfile                  " No swap file

" Search
set incsearch                   " Incremental search
set hlsearch                    " Highlight matches
set ignorecase                  " Case-insensitive search...
set smartcase                   " ...unless search contains uppercase letter

" Indentation
set smarttab                    " Better tabs
set smartindent                 " Insert new level of indentation
set autoindent                  " Copy indentation from previous line
set tabstop=2                   " Columns a tab counts for
set softtabstop=2               " Columns a tab inserts in insert mode
set shiftwidth=2                " Columns inserted with the reindent operations
set shiftround                  " Always indent by multiple of shiftwidth
set expandtab                   " Always use spaces instead of tabs

" Key sequence timeout
set ttimeout                    " Enable time out
set ttimeoutlen=0               " Disable key code delay

" Scroll
set sidescrolloff=3             " Keep at least 3 lines left/right
set scrolloff=3                 " Keep at least 3 lines above/below

" Mouse
set mousehide                   " Hide mouse when typing
set mouse-=a

" Treat given characters as a word boundary
set iskeyword-=.                " Make '.' end of word designator
set iskeyword-=#                " Make '#' end of word designator

" Splits
set splitbelow                  " Horizontal split below
set splitright                  " Vertical split right

" Spell checking
set spelllang=en_us             " English as default language
set nospell                     " Disable by default

" Make completion menu behave like an IDE
set completeopt=longest,menuone,preview

" History
set history=1000                " Remember more commands
if has('persistent_undo')
    set undofile                " Persistent undo
    set undodir=~/.vim/undo     " Location to store undo history
    set undolevels=1000         " Max number of changes
    set undoreload=10000        " Max lines to save for undo on a buffer reload
endif


" ---------------------------------------------------------------------------- "
" Key Mappings                                                                 "
" ---------------------------------------------------------------------------- "

" Typos
cnoreabbrev E e
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev W w

" Save file which you forgot to open with sudo
cnoremap w!! w !sudo tee % >/dev/null

" Redraw the screen and remove highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>

" ---------------------------------------------------------------------------- "
" Auto Commands                                                                "
" ---------------------------------------------------------------------------- "

" Watch my .vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup end

" ---------------------------------------------------------------------------- "
" Plugins Settings                                                             "
" ---------------------------------------------------------------------------- "

"" vim-session
let g:session_autosave = 'no'

"" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

"" fzf
let g:fzf_buffers_jump=1
nnoremap \ :Rg<SPACE>
vnoremap _ y :Rg <C-R>"<CR>
nnoremap _ yaw :Rg <C-R>"<CR>
map <C-f> :Files<CR>
map <C-b> :Buffers<CR>
map <C-t> :Tags<CR>

"" detectindent
let g:detectindent_preferred_expandtab=1
let g:detectindent_preferred_indent=2


"" tarbar
let g:tagbar_autofocus=0
let g:tagbar_compact=1
let g:tagbar_right=1
let g:tagbar_width=35
nnoremap <leader>tt :TagbarToggle<CR>


"" Doxygen
let g:DoxygenToolkit_commentType="C++"

"" nerdtree-git-plugin
autocmd StdinReadPre * let s:std_in=1
map <C-n> :NERDTreeToggle<CR>

"" nerdtree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "𝚫",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }"

"" nerdtree-fzf

if exists("g:loaded_nerdtree_fzf_menuitem")
  finish
endif

let g:loaded_nerdtree_fzf_menuitem = 1
let s:haskdeinit = system("ps -e") =~ 'kdeinit'
let s:hasdarwin = system("uname -s") =~ 'Darwin'

" LSP
let g:lsp_signs_enabled=1
nnoremap <leader>ld :LspDefinition<CR>
nnoremap <leader>lf :LspDocumentFormat<CR>
nnoremap <leader>lh :LspHover<CR>
nnoremap <leader>lr :LspReferences<CR>

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
        autocmd FileType rs setlocal omnifunc=lsp#complete
endif
