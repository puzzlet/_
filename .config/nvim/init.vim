" farewell old vi
set nocompatible

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set modeline

set noswapfile
set nobackup
set nowritebackup

if version >= 830
    set undodir=~/.vim/backups
    set undofile
endif

set hlsearch
set incsearch

set mouse=

autocmd BufNewFile,BufRead *.j2     set filetype=jinjahtml
autocmd BufNewFile,BufRead *.pde    setf arduino
autocmd BufNewFile,BufRead *.yaml,*.yml    setf yaml

if version >= 830
    highlight ColorColumn ctermbg=black guibg=black
    set colorcolumn=80
endif
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"autocmd FileType python compiler pylint

filetype plugin indent on

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <Up> gk
map <Down> gj
cmap w!! %!sudo tee > /dev/null %
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

" syntax
Plug 'neomake/neomake'

Plug 'ingydotnet/yaml-vim'
Plug 'tpope/vim-markdown'

" colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'nanotech/jellybeans.vim'

" etc
Plug 'airblade/vim-gitgutter'
Plug 'amix/open_file_under_cursor.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'will133/vim-dirdiff'
Plug 'tpope/vim-unimpaired'

call plug#end()

set shellredir=>
let g:neomake_python_prospector_maker = {
    \ 'args': ['-o', 'pylint', '-M', '--absolute-paths', '%:p', '-W', 'pylint'],
    \ 'errorformat':
        \ '%-G%.%#Module%.%#,' .
        \ '%-G%.%#module named%.%#,' .
        \ '%f:%l:%c [%t%n%.%#] %m,' .
        \ '%f:%l: [%t%n%.%#] %m,' .
        \ '%f:%l: [%.%#] %m,' .
        \ '%f:%l:%c [%.%#] %m',
    \ }
let g:neomake_python_pylint_maker = {
    \ 'args': [
        \ '--load-plugins', 'pylint_django',
        \ '-f', 'text',
        \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
        \ '-r', 'n'
    \ ],
    \ 'errorformat':
        \ '%A%f:%l:%c:%t: %m,' .
        \ '%A%f:%l: %m,' .
        \ '%A%f:(%l): %m,' .
        \ '%-Z%p^%.%#,' .
        \ '%-G%.%#',
    \ }
let g:neomake_python_enabled_makers = ['prospector', 'pylint']
autocmd! BufWritePost,BufReadPost * Neomake
autocmd! VimLeave * let g:neomake_verbose = 0

" solarize
" TODO: Like cygwin, connectbot should NOT use solarized
if $TERM != 'cygwin'
    let g:solarized_italic=0
    if has('gui_running')
        let g:solarized_termcolors=256
        set t_Co=256
    elseif $COLORTERM == 'gnome-terminal'
        " already has solarized theme
        let g:solarized_termcolors=16
        set t_Co=16
    else
        let g:solarized_termcolors=8
        set t_Co=8
    endif
    colorscheme solarized
    set background=dark
endif

if &diff
    colorscheme jellybeans
endif

" ignore whitespaces
set diffopt+=iwhite

if filereadable(expand("$HOME/.vimrc_private"))
    source ~/.vimrc_private
endif
