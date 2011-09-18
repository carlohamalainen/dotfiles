syntax on

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set incsearch
set visualbell

" http://www.vex.net/~x/python_and_vim.html
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
" im :<CR> :<CR><TAB>



"""""""""""""""""""""""""""""""""""""""""""""""""""

" iab pp <p>
" iab cp </p>
"iab  bdate  <h3><c-r>=strftime("%a %d %b %Y :: %H:%M")<cr></h3><cr><blockquote><cr><cr><p><cr><cr></blockquote><cr>


iab ipydb     import IPython<cr>IPython.Shell.IPShell(user_ns=dict(globals(), **locals())).mainloop()

iab pyutf # -*- coding: utf-8 -*-

" turn off autoindent
" :set noai

" show matching bracket
:set showmatch

"these characters can move past end of line
:set whichwrap=b,s,h,l

" Don't annoy my neighbours (visual bell)
set vb

" Usually search case insensitive
set ignorecase

" Incremental searching
set incsearch

" This block maps the 'q' key to format a paragraph.
set shell=/bin/csh redraw
map K !} fmt -72 -c
map U !} fmt -72 -c
"map q K}

" Try wrapping stuff at 72.
" set tw=72

set tw=0

" Map F8 to write the file.
map <F8> :w
	
" blah: map <F9> :!latex % && dvips %:r.dvi -o %:r.ps<CR>
	" map <F9> :!pdflatex % <CR>
	"map <M-d> :!evince %:r.pdf &<CR><CR>

" LaTeX
function! LaTeXMode()
	map <F9> :!rubber --pdf -o natbib %:r <CR>
	map <M-d> :!evince %:r.pdf &<CR><CR>
endfunction
au BufNewFile,BufRead *.tex call LaTeXMode()

au! BufNewFile,BufRead *.nw setf noweb


" SageTeX
" augroup filetypedetect
" au! BufRead,BufNewFile *.tex    setfiletype sagetex
" augroup END

" filetype plugin on
" set ofu=syntaxcomplete#Complete

" nnoremap <space> za
" vnoremap <space> zf






"augroup filetypedetect
"  au! BufRead,BufNewFile *.sage,*.spyx,*.pyx setfiletype python
"augroup END

autocmd BufRead,BufNewFile *.sage,*.pyx,*.spyx set filetype=python


" Settings for VimClojure
set nocompatible
filetype plugin indent on
syntax on
let vimclojure#HighlightBuiltins = 1
"let vimclojure#ParenRainbow = 1

vmap <F5> "ry :call Send_to_Screen(@r)<CR>
nmap <F5> vip<C-c><C-c>



