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

iab pp <p>
iab cpp </p>

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
" map <F9> :!pdflatex % <CR>
" map <F9> :!rubber --pdf -o natbib %:r <CR>
map <F9> :!./go <CR>


" For Haskell stuff: pathogen for modules, e.g. syntastic, ghcmod-vim, ...
" https://github.com/tpope/vim-pathogen/
execute pathogen#infect()
syntax on
filetype plugin indent on

" hdevtools
" au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
" au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>

" Tell syntastic to pyflakes for Python files.
let g:syntastic_python_checkers = ['pyflakes']

" Check with syntastic on open.
let g:syntastic_check_on_open=1

" Nicer colours for errors and warnings (in an xterm).
highlight SyntasticError   ctermfg=red
highlight SyntasticWarning ctermbg=lightgrey

au FileType haskell nnoremap <buffer> <F4> :GhcImportedFromOpenHaddock<CR>
au FileType lhaskell nnoremap <buffer> <F4> :GhcImportedFromOpenHaddock<CR>

au FileType haskell nnoremap <buffer> <F5> :GhcImportedFromEchoUrl<CR>
au FileType lhaskell nnoremap <buffer> <F5> :GhcImportedFromEchoUrl<CR>

au FileType haskell  vnoremap <S-F4> :<C-u> :GhcImportedFromOpenHaddockVismode<CR>
au FileType lhaskell vnoremap <S-F4> :<C-u> :GhcImportedFromOpenHaddockVismode<CR>

au FileType haskell  vnoremap <S-F5> :<C-u> :GhcImportedFromEchoUrlVismode<CR>
au FileType lhaskell vnoremap <S-F5> :<C-u> :GhcImportedFromEchoUrlVismode<CR>

au FileType haskell nnoremap <buffer> <F1> :GhcModType<CR>
au FileType haskell nnoremap <buffer> <F2> :GhcModInfo<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :GhcModTypeClear<CR>

au FileType lhaskell nnoremap <buffer> <F1> :GhcModType<CR>
au FileType lhaskell nnoremap <buffer> <F2> :GhcModInfo<CR>
au FileType lhaskell nnoremap <buffer> <silent> <F3> :GhcModTypeClear<CR>

" let g:ghcmod_browser = '/usr/bin/iceweasel'
let g:ghcimportedfrom_browser = '/usr/bin/google-chrome'

" let g:ghcimportedfrom_ghc_options    = ['-global']
" let g:ghcimportedfrom_ghcpkg_options = ['--global', '--package-db /home/carlo/work/github/ghc-imported-from/.cabal-sandbox/x86_64-linux-ghc-7.6.3-packages.conf.d']


" autocmd BufWritePost *.hs  GhcModCheckAndLintAsync
" autocmd BufWritePost *.lhs GhcModCheckAndLintAsync
autocmd BufWritePost *.hs  GhcModCheckAsync
autocmd BufWritePost *.lhs GhcModCheckAsync

"if has('gui_running')
"    syntax enable
"    set background=dark
"    colorscheme solarized
"endif
