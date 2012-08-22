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
    set background=dark
    let g:solarized_italic=0
    if $TERM != "screen"
        let g:solarized_termcolors=256
    endif
    colorscheme solarized
endif