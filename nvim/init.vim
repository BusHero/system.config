set nu
syntax on
set clipboard+=unnamed
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set mouse=v
set cc=80

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'junegunn/vim-easy-align'
Plug 'https://tpope.io/vim/surround.git'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/pboettch/vim-cmake-syntax'

call plug#end()