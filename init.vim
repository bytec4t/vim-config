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

" Plugins---------------------------------
" elixir
NeoBundle 'slashmili/alchemist.vim'
NeoBundle 'elixir-lang/vim-elixir'
" elm
NeoBundle 'ElmCast/elm-vim'
" markup
NeoBundle 'cespare/vim-toml'
NeoBundle 'lervag/vimtex'
" php
NeoBundle 'StanAngeloff/php.vim'
" rust
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'racer-rust/vim-racer'
" workflow
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'justinmk/vim-sneak'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'christoomey/vim-tmux-navigator'
" other
NeoBundle 'vimwiki/vimwiki'
" End Plugins----------------------------


call neobundle#end()
filetype plugin indent on

" ask to install plugins at vim startup
NeoBundleCheck
" End NeoBundle Scripts -----------------


" Airline Configuration -----------------
let g:airline#extensions#tmuxline#enabled = 1

" Deoplete Configuration ----------------
let g:deoplete#enable_at_startup=1

" NERDTree Configuration ----------------
" open by deyault
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" auto delete buffer when file is deleted
let NERDTreeAutoDeleteBuffer = 1
" clean up the ui
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Racer Configuration -------------------
set hidden
let g:racer_cmd="racer"
let $RUST_SRC_PATH="/usr/src/rust/src"

" VimWiki Configuration -----------------
let g:vimwiki_list = [{
    \ 'path': '$HOME/docs/wiki/',
    \ 'template_path': '$HOME/docs/wiki/templates/',
    \ 'template_default': 'default',
    \ 'template_ext:': '.html',
    \ 'autotoc': 1}]

" syntax highlighting
hi VimwikiHeader1 cterm=bold ctermfg=011
hi VimwikiHeader2 cterm=bold ctermfg=024
hi VimwikiHeader3 cterm=bold ctermfg=009
hi VimwikiHeader4 cterm=bold ctermfg=000
hi VimwikiLink ctermfg=037
hi VimwikiListTodo ctermfg=077

" NeoVim Configuration ------------------
" backup
set nobackup
set nowb
set noswapfile

" column coloring
highlight ColorColumn ctermbg=235
let &colorcolumn="80"

" keybindings
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" keyboard completion
set complete=.,w,b,u,t

" line numbers
set number
set relativenumber

" matching brackets
set showmatch

" searching
set ignorecase
set smartcase

" syntax highlighting
highlight PreProc cterm=bold ctermfg=2
highlight Identifier cterm=none ctermfg=3
highlight Comment cterm=italic ctermfg=4
syntax enable

" tab behavior
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" tab completion
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
