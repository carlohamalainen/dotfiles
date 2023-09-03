" :PlugInstall
" :PlugUpgrade

call plug#begin('~/.vim/plugged')

" Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'scrooloose/syntastic'
"Plug 'benekastah/neomake'
"Plug 'Shougo/vimproc.vim', 	                    { 'do': 'make' }
"Plug 'eagletmt/ghcmod-vim',                     {'for': 'haskell'}
"Plug 'eagletmt/neco-ghc'
"Plug 'carlohamalainen/ghcimportedfrom-vim',     {'for': 'haskell'}
"Plug 'neovim/python-client'
"Plug 'zchee/deoplete-jedi'
Plug 'kien/ctrlp.vim'
Plug 'preservim/nerdcommenter'


"Plug 'carlohamalainen/ghcmod-vim', { 'branch': 'ghcmod-imported-from-cmd', 'for': 'haskell'  }
"Plug 'carlohamalainen/ghcmod-vim', { 'branch': 'ghcmod-imported-from-cmd', 'for': 'lhaskell' }

" SnipMate
"          Plug 'MarcWeber/vim-addon-mw-utils'
"          Plug 'tomtom/tlib_vim'
"          Plug 'garbas/vim-snipmate'
"          Plug 'honza/vim-snippets'


"          Plug 'LnL7/vim-nix'

"          Plug 'scrooloose/syntastic'

"          Plug 'preservim/nerdcommenter'

"          Plug 'junegunn/vim-peekaboo'

"Plug 'Twinside/vim-hoogle',    {'for': 'haskell'}
"Plug 'janko-m/vim-test'
"Plug 'raichoo/haskell-vim',    {'for': 'haskell'}

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

"Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

call plug#end()


syntax on

"iab pp <p>
"iab cpp </p>

"""""""""""""""""""""""""""""""""""""""""""""""""""

" show matching bracket
:set showmatch

"these characters can move past end of line
:set whichwrap=b,s,h,l

" Don't annoy my neighbours (visual bell)
" set vb

" Usually search case insensitive
set ignorecase

" Incremental searching
set incsearch

" This block maps the 'q' key to format a paragraph.
" set shell=/bin/csh redraw
" map K !} fmt -72 -c
" map U !} fmt -72 -c
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

" Tell syntastic to pyflakes for Python files.
let g:syntastic_python_checkers = ['pyflakes']

" let g:syntastic_racket_racket_args="--load"
let g:syntastic_racket_code_ayatollah_script = "/home/carlo/code-ayatollah.rkt"


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0



" Check with syntastic on open.
let g:syntastic_check_on_open=1

" Nicer colours for errors and warnings (in an xterm).
highlight SyntasticError   ctermfg=red
highlight SyntasticWarning ctermbg=lightgrey


au FileType haskell nnoremap <buffer> <F4> :GhcModOpenDoc<CR>
au FileType lhaskell nnoremap <buffer> <F4> :GhcModOpenDoc<CR>

au FileType haskell nnoremap <buffer> <F5> :GhcModDocUrl<CR>
au FileType lhaskell nnoremap <buffer> <F5> :GhcModDocUrl<CR>

au FileType haskell  vnoremap <S-F4> :<C-u> :GhcModOpenHaddockVismode<CR>
au FileType lhaskell vnoremap <S-F4> :<C-u> :GhcModOpenHaddockVismode<CR>

au FileType haskell  vnoremap <S-F5> :<C-u> :GhcModEchoUrlVismode<CR>
au FileType lhaskell vnoremap <S-F5> :<C-u> :GhcModEchoUrlVismode<CR>

au FileType haskell nnoremap <buffer> <F1> :GhcModType<CR>
au FileType haskell nnoremap <buffer> <F2> :GhcModInfo<CR>
au FileType haskell nnoremap <buffer> <silent> <F3> :GhcModTypeClear<CR>

au FileType lhaskell nnoremap <buffer> <F1> :GhcModType<CR>
au FileType lhaskell nnoremap <buffer> <F2> :GhcModInfo<CR>
au FileType lhaskell nnoremap <buffer> <silent> <F3> :GhcModTypeClear<CR>




let g:ghcmod_browser = '/usr/bin/firefox'
" let g:ghcimportedfrom_browser = '/usr/bin/google-chrome'
" let g:ghcimportedfrom_browser = '/opt/firefox/firefox'

" let g:ghcimportedfrom_ghc_options    = ['-blap']
" let g:ghcimportedfrom_ghcpkg_options = ['--global', '--package-db=/home/carlo/work/github/ghc-imported-from/.cabal-sandbox/x86_64-linux-ghc-7.6.3-packages.conf.d']

" autocmd BufWritePost *.hs  GhcModCheckAndLintAsync
" autocmd BufWritePost *.lhs GhcModCheckAndLintAsync

"autocmd BufWritePost *.hs  GhcModCheckAsync
"autocmd BufWritePost *.lhs GhcModCheckAsync

let g:neocomplcache_enable_at_startup = 1

" Bind Ctrl-e to toggle the error list. Bliss.
" http://stackoverflow.com/questions/17512794/toggle-error-location-panel-in-syntastic
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>


let g:vim_markdown_folding_disabled=1

let g:necoghc_debug=1

" https://github.com/aloiscochard/codex#codex
set tags=tags;/,codex.tags;/

set guifont=Monospace\ 10


" https://github.com/ctrlpvim/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set t_Co=256

" https://stackoverflow.com/questions/21618614/vim-shows-garbage-characters
autocmd VimEnter * redraw!

set cryptmethod=blowfish2

"colo torte

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set incsearch
"set visualbell
set autoindent


map <Leader>d !!date '+\%d \%B \%Y'<CR>

map <Leader>0 :e /home/carlo/0.txt<CR>

let g:snipMate = { 'snippet_version' : 1 }



" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1


" https://github.com/neoclide/coc.nvim#example-vim-configuration
" nmap <silent> gy <Plug>(coc-type-definition)



" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

nnoremap <silent> <leader>c} V}:call nerdcommenter#Comment('x', 'toggle')<CR>
nnoremap <silent> <leader>c{ V{:call nerdcommenter#Comment('x', 'toggle')<CR>


