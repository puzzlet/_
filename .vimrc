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
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
"set t_Co=16
