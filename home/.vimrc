" Display
set relativenumber
syntax on

" Mappings
imap jj <Esc>

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim' 
Plug 'sheerun/vim-polyglot'

call plug#end()

colorscheme onedark
