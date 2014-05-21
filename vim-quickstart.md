### Getting Started

If you don't have a ```~/.vimrc```, start with this:

    syntax on
    set softtabstop=4
    set shiftwidth=4
    set tabstop=4
    set expandtab
    set incsearch
    set visualbell
    set autoindent

Install Pathogen:

    mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

Add these lines to ```~/.vimrc``` to enable Pathogen:

    execute pathogen#infect()
    syntax on
    filetype plugin indent on

### VimShell

Homepage: https://github.com/Shougo/vimshell.vim

    cd ~/.vim/bundle
    git clone https://github.com/Shougo/vimshell.vim.git
    cd

### Syntastic

Homepage: https://github.com/scrooloose/syntastic

    cd ~/.vim/bundle
    https://github.com/scrooloose/syntastic.git
    cd

Add to ```~/.vimrc```:

    " Tell syntastic to pyflakes for Python files.
    let g:syntastic_python_checkers = ['pyflakes']

    " Check with syntastic on open.
    let g:syntastic_check_on_open=1

    " Colour errors red, warnings light grey.
    highlight SyntasticError   ctermfg=red
    highlight SyntasticWarning ctermbg=lightgrey

