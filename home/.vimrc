" Display
set relativenumber
syntax on
set termguicolors

" Mappings
imap jj <Esc>
map <C-N> :NERDTreeToggle<CR>
map <A-N> :NERDTreeFocus<CR>
map gD :ALEGoToDefinition<CR>
let g:ale_completion_enabled = 1

" Plugins
call plug#begin('~/.vim/plugged')

" General
Plug 'w0rp/ale'
Plug 'Quramy/tsuquyomi'
Plug 'janko-m/vim-test'
Plug '/usr/local/opt/fzf'
Plug 'airblade/vim-gitgutter'
Plug 'wincent/command-t', {
    \   'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
    \ }
Plug 'scrooloose/nerdcommenter'

" Theming
Plug 'joshdick/onedark.vim' 
Plug 'sheerun/vim-polyglot'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'

" Formatting
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-sleuth'

" Languages
Plug 'leafgarland/typescript-vim'
Plug 'jiangmiao/auto-pairs'

" Linting
Plug 'jason0x43/vim-js-indent'

" Snippets
" Start neosnippet script
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" let g:neosnippet#enable_snipmate_compatibility = 0;
"  "let g:neosnippet#disable_runtime_snippets = 1
let g:neosnippet#snippets_directory='~/development/snippets/snip'

Plug 'Shougo/neosnippet.vim'
"  "Plug 'Shougo/neosnippet-snippets'
" End neosnippet script
" Plug 'honza/vim-snippets'

" Start snippet config
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"

call plug#end()

" Navigation
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber

" Formatting
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:NERDSpaceDelims = 1

" Linting
let g:ale_lint_on_save = 1

" Theming
colorscheme onedark
