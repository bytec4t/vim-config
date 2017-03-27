" NeoBundle Scripts------------------------
if has('vim_starting')
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
  set runtimepath+=~/.config/nvim/
endif

let neobundle_readme=expand('~/.config/nvim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.config/nvim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim/
  let g:not_finish_neobundle = "yes"
endif

call neobundle#begin(expand('$HOME/.config/nvim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'neomake/neomake'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'racer-rust/vim-racer'
NeoBundle 'alessandroyorba/despacio'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vimwiki/vimwiki'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'slashmili/alchemist.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'StanAngeloff/php.vim'
NeoBundle 'cespare/vim-toml'
NeoBundle 'lervag/vimtex'
NeoBundle 'vim-airline/vim-airline'


call neobundle#end()
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.ZZZZ
NeoBundleCheck


""" Plugin Configurations
" deoplete
let g:deoplete#enable_at_startup=1

" vim-racer
set hidden
let g:racer_cmd="racer"
let $RUST_SRC_PATH="/usr/src/rust/src"

" vimwiki
hi VimwikiHeader1 ctermfg=091
hi VimwikiHeader2 ctermfg=203
hi VimwikiHeader3 ctermfg=049
hi VimwikiLink ctermfg=037
hi VimwikiListTodo ctermfg=077

" airline
let g:airline#extensions#tmuxline#enabled = 1

""" NeoVim Configuration
" Backup
set nobackup
set nowb
set noswapfile

" Column Coloring
highlight ColorColumn ctermbg=235
let &colorcolumn="80"

" Folding
"set foldmethod=syntax

" Keyboard Completion
set complete=.,w,b,u,t

" Line Numbers
set number
set relativenumber

" Matching Brackets
set showmatch

" Searching
set ignorecase
set smartcase

" Tab Behavior
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" for html and php use 2
autocmd BufNewFile,BufRead *.html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.php setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Tab completion
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Colors
"set background=dark
"highlight Comment ctermfg=240
"highlight Statement ctermfg=130
"highlight PreProc ctermfg=15
syntax enable


""" Key Remaps
" Use Ctrl-* instead of Ctrl-w + * for split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
