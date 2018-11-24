" Display
set relativenumber
syntax on

" Mappings
imap jj <Esc>
map <C-n> :NERDTreeToggle<CR>
map <C-S-n> :NERDTreeFocus<CR>
map gD :ALEGoToDefinition<CR>
let g:ale_completion_enabled = 1

" Plugins
call plug#begin('~/.vim/plugged')

" General
Plug 'w0rp/ale'
Plug 'janko-m/vim-test'
Plug '/usr/local/opt/fzf'

" Theming
Plug 'joshdick/onedark.vim' 
Plug 'sheerun/vim-polyglot'

" Navigation
Plug 'scrooloose/nerdtree'

" Formatting
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-sleuth'

" Languages
Plug 'leafgarland/typescript-vim'

" Linting
Plug 'jason0x43/vim-js-indent'

call plug#end()

" Navigation
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

" Formatting
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" Linting
let g:ale_lint_on_save = 1

colorscheme onedark
