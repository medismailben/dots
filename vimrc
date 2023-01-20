set nocompatible    " Disable vi retro-compatibility

" ---------------------------------------------------------------------------- "
" Plugins                                                                      "
" ---------------------------------------------------------------------------- "

call plug#begin('~/.vim/plugged')

Plug 'mhartington/oceanic-next'       " Colorscheme

Plug 'Chiel92/vim-autoformat'         " Code formatter integration
Plug 'JDevlieghere/llvm.vim'          " LLVM specific settings
Plug 'Xuyuanp/nerdtree-git-plugin'    " Versioning status
Plug 'airblade/vim-gitgutter'         " Git changes in the Sign column
Plug 'ajh17/vimcompletesme'           " Leightweight autocompletion engine
Plug 'ciaranm/detectindent'           " Indent according to the current file
Plug 'itchyny/lightline.vim'          " Lightweight powerline
Plug 'jiangmiao/auto-pairs'           " Brackets, parentheses, quotes completion
Plug 'junegunn/fzf',                  { 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'               " Command-line fuzzy finder
Plug 'junegunn/goyo.vim'              " Distration-free writing
Plug 'junegunn/gv.vim'                " Display git commits log
Plug 'junegunn/limelight.vim'         " Hyperfocus section highlighter
Plug 'junegunn/vim-emoji'             " Emoji support
Plug 'junegunn/vim-slash'             " Enhancing in-buffer search experience
Plug 'majutsushi/tagbar'              " Files ctags on a sidebar
Plug 'mbbill/undotree'                " Undo history
Plug 'moll/vim-bbye'                  " Close all files without quitting vim
Plug 'pboettch/vim-cmake-syntax'      " CMake syntax highlight
Plug 'prabirshrestha/async.vim'       " Asynchronous
Plug 'prabirshrestha/vim-lsp'         " LSP server
Plug 'scrooloose/nerdtree'            " Tree explorer
Plug 'sheerun/vim-polyglot'           " Lazy loading language pack
Plug 'tmhedberg/SimpylFold'           " Python code folding
Plug 'tpope/vim-commentary'           " Comment shortcut
Plug 'tpope/vim-fugitive'             " Git wrapper
Plug 'vim-scripts/DoxygenToolkit.vim' " Doxygen style comments
Plug 'vim-scripts/SearchComplete'     " Search tab completion
Plug 'vim-scripts/a.vim'              " Source/Header switcher
Plug 'vim-scripts/commentary.vim'     " Comment toggle
Plug 'vim-scripts/errormarker.vim'    " Show compile error in-place
Plug 'vim-scripts/swig'
Plug 'xolox/vim-misc'                 " Miscellaneous vim scripts
Plug 'xolox/vim-session'              " Session manager
Plug 'yuttie/comfortable-motion.vim'  " Physics-based scolling
Plug 'zivyangll/git-blame.vim'        " Git blame on the status bar

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
set textwidth=80                " Wrap line after 80 characteres.
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
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }


function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction


"" fzf
let g:fzf_buffers_jump=1
"nnoremap \ :Rg<SPACE>
"vnoremap _ y :Rg <C-R>"<CR>
"nnoremap _ yaw :Rg <C-R>"<CR>
"map <C-f> :Files<CR>
"map <C-b> :Buffers<CR>
"map <C-t> :Tags<CR>

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

"" LSP
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implmentation)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> g] <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
"" Fix Shell Folding
set foldmethod=marker
au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax


  let g:lsp_format_sync_timeout = 1000
endfunction

" Swift-LSP
if executable('sourcekit-lsp')
  augroup lsp_sourcekit_lsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'sourcekit-lsp',
          \ 'cmd': {server_info->['sourcekit-lsp']},
          \ 'allowlist': ['swift', 'c', 'cpp', 'objc', 'objcpp', 'h'],
          \ 'blocklist': ['def'],
          \ })
  augroup end
endif

" C++-LSP
if executable('clangd')
  augroup lsp_clang
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'clandg',
          \ 'cmd': {server_info->['clangd']},
          \ 'allowlist': ['h', 'c', 'cpp', 'objc', 'objcpp'],
          \ 'blocklist': ['def'],
          \ })
  augroup end
endif

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


if executable('rls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
  autocmd FileType rs setlocal omnifunc=lsp#complete
endif

" Tags
" let g:gutentags_cache_dir = '~/.cache/gutentags'
" set statusline+=%{gutentags#statusline()}
" "Open the current tag in a new tab, or a vertical split.
" map <C-]> :tab split<CR>:execute "tag " . expand( "<cword>" )<CR>zz<C-w>p


" Teach a.vim about llvm project layout.
let g:alternateSearchPath = 'reg:|/source|/include/lldb|g,reg:|/include/lldb|/source|g,reg:|/include/swift|/lib|g,reg:|/lib|/include/swift|g,reg:|/include/clang|/lib|g,reg:|/lib|/include/clang|g,reg:|/include/llvm|/lib|g,reg:|/lib|/include/llvm|g'
let g:alternateNoDefaultAlternate = 1

"Resize splits when the window is resized.
autocmd VimResized * exe "normal! \<c-w>="

set guitablabel=\[%N\]\ %t\ %M
