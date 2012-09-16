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

set undodir=~/.vim/backups
set undofile

set hlsearch
set incsearch

autocmd BufNewFile,BufRead *.j2 set filetype=jinjahtml
autocmd BufNewFile,BufRead *.pde setf arduino
autocmd BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

set colorcolumn=80
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

"autocmd FileType python compiler pylint

filetype plugin indent on

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
cmap w!! %!sudo tee > /dev/null %

call pathogen#infect()

syntax enable

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

if filereadable(expand("$HOME/.vimrc_private"))
    source ~/.vimrc_private
endif
