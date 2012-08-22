" farewell old vi
set nocompatible

set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set modeline

autocmd BufNewFile,BufRead *.j2 set filetype=jinjahtml
autocmd BufNewFile,BufRead *.pde setf arduino
autocmd BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

"autocmd FileType python compiler pylint

filetype plugin indent on

call pathogen#infect()

syntax enable

" solarize
if $TERM != "cygwin"
    let g:solarized_italic=0
    if $TERM != "screen"
        let g:solarized_termcolors=256
    endif
    if $COLORTERM == "gnome-terminal"
        " already has solarized theme
        let g:solarized_termcolors=16
        set t_Co=16
    endif
    colorscheme solarized
    set background=dark
endif
