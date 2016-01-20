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

autocmd BufNewFile,BufRead *.j2 set filetype=jinjahtml
autocmd BufNewFile,BufRead *.pde setf arduino
autocmd BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

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

let s:script_root=fnamemodify(resolve(expand('<sfile>')), ':p:h')
execute "source " . s:script_root . "/.vim/vim-pathogen/autoload/pathogen.vim"
let s:tmp = s:script_root . "/.vim/bundle/{}"
call pathogen#infect(s:tmp)

syntax enable

let g:syntastic_check_on_open=1

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
    colorscheme solarized
endif

" ignore whitespaces
set diffopt+=iwhite

if filereadable(expand("$HOME/.vimrc_private"))
    source ~/.vimrc_private
endif
