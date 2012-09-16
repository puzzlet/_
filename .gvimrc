if has("win32") || has("win64")
    source $VIMRUNTIME/mswin.vim
    behave mswin

    set fileencodings=utf-8

    " restore UI language
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    " NOTE: guifontwide requires encoding=utf-8, which breaks UI language in
    "       non-utf-8 environment such as Windows.
    "       In that case, just delete the directory $VIMRUNTIME/lang .
    set encoding=utf-8

    set guifont=Consolas:h16
    set guifontwide=MS_Gothic:h16
    " TEST: IlioO0 ㅁㄴㅇㄹ 日本語 한글

    " no menu, no toolbar
    set guioptions=

    " IME status
    highlight Cursor guibg=green guifg=NONE
    highlight CursorIM guibg=red guifg=NONE
endif
