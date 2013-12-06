syntax on

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set incsearch
set visualbell
set autoindent

iab malmo Malmö
iab Malmo Malmö

"""""""""""""""""""""""""""""""""""""""""""""""""""

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

set tw=0

" Map F8 to write the file.
map <F8> :w
	
" Sometimes long lines stuff up syntax highlighting. Andrej Panjkov pointed me
" to a post by Bram Moolenaar who recommended
set synmaxcol=40000

" blah: map <F9> :!latex % && dvips %:r.dvi -o %:r.ps<CR>
map <F9> :!pdflatex % <CR>
" map <F9> :!rubber --pdf -o natbib %:r <CR>


" For Haskell stuff: pathogen for modules, e.g. hdevtools, syntastic.
" https://github.com/tpope/vim-pathogen/
execute pathogen#infect()
syntax on
filetype plugin indent on

" hdevtools
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>

" Use pyflakes
let g:syntastic_python_checkers = ['pyflakes']

" Change the highlighting of errrors and warning in Syntastic
highlight SyntasticError   ctermfg=red
highlight SyntasticWarning ctermbg=lightgrey
