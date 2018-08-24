"                       Daylen's NeoVim Configuration
"
" Permission granted to do whatever the hell you want with this.


" --- Dein Plugin Manager ---

" Make sure `nocompatible` is set since Dein requires it.
if &compatible
    set nocompatible
endif

" Path to exec for Dein plugin manager.
set runtimepath+=~/.config/nvim/bundles/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.config/nvim/bundles/dein')
    call dein#begin('~/.config/nvim/bundles/dein')

    call dein#add('~/.config/nvim/bundles/dein')

    " Deoplete completions
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    " Completions plugins
    call dein#add('Shougo/neco-syntax') " General syntax completions
    call dein#add('sebastianmarkow/deoplete-rust') " Rust completions
    call dein#add('slashmili/alchemist.vim') " Elixir completions
    call dein#add('pbogut/deoplete-elm') " Elm completions
    call dein#add('carlitux/deoplete-ternjs') " JavaScript completions
    call dein#add('wellle/tmux-complete.vim') " Tmux pane completions

    " Syntax highlighting and linting
    call dein#add('vim-syntastic/syntastic')
    call dein#add('elixir-lang/vim-elixir')
    call dein#add('ElmCast/elm-vim')
    call dein#add('cespare/vim-toml')
    call dein#add('lervag/vimtex')
    call dein#add('pangloss/vim-javascript')
    call dein#add('LnL7/vim-nix')
    call dein#add('rust-lang/rust.vim')
    call dein#add('pangloss/vim-javascript')

    " Elixir formatting
    call dein#add('mhinz/vim-mix-format')

    " HTML/XML (and friends) formatting
    call dein#add('tpope/vim-ragtag')

    " Short-medium range navigation
    call dein#add('justinmk/vim-sneak')

    " Git wrapper for evoking Git commands within Vim
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-rhubarb')

    " Filetree browser
    call dein#add('scrooloose/nerdtree')
    call dein#add('Xuyuanp/nerdtree-git-plugin')

    " Status/tabline
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    " Vimwiki
    call dein#add('vimwiki/vimwiki')

    " Easy editting of parentheses, brackets, quotes, markup, etc.
    call dein#add('tpope/vim-surround')

    " Plugin repetition with "."
    call dein#add('tpope/vim-repeat')

    " Distraction free mode
    call dein#add('junegunn/goyo.vim')

    " Brighten the lines around the current line.
    call dein#add('junegunn/limelight.vim')

    " Colorscheme
    call dein#add('arcticicestudio/nord-vim')

    " Autoclose characters that come in pairs (ex. `(` becomes `()`)
    call dein#add('townk/vim-autoclose')

    call dein#end()
    call dein#save_state()
endif


" Check if there are any packages needing to be installed and install them
" at startup.
if dein#check_install()
  call dein#install()
endif


" --- Plugin Configuration ---

" Enable Deoplete at startup
let g:deoplete#enable_at_startup = 1

" Set completion sources for Deoplete
let g:deoplete#sources#rust#racer_binary = 'which racer'
let g:deoplete#sources#rust#show_duplicates = 1
let g:deoplete#sources#ternjs#tern_bin = 'which tern'
let g:deoplete#sources#ternjs#timeout = 1

" Remove the tmux-complete trigger since we are using Deoplete
let g:tmuxcomplete#trigger = ''


" Airline Configuration -----------------
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'

" Goyo configuration
let g:goyo_width = 82 " because I use line numbers

function! s:goyo_enter()
    set number
    set relativenumber
    Limelight
endfunction

function! s:goyo_leave()
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Mix Format
let g:mix_format_on_save = 1
let g:mix_format_options = '--check-equivalent'

" NERDTree Configuration ----------------
map \f :NERDTreeToggle<CR>

" Syntastic Configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic checkers to use.
let g:syntastic_enable_elixir_checker = 1
let g:syntastic_elixir_checkers = ["elixir"]
let g:syntastic_javascript_checkers = ["jshint"]

" VimWiki Configuration
let g:vimwiki_list = [{
            \ 'path': '$HOME/doc/wiki/',
    \ 'template_path': '$HOME/doc/wiki/templates/',
    \ 'template_default': 'default',
    \ 'template_ext:': '.html',
    \ 'autotoc': 1}]



" --- NeoVim Configuration ---


" Detect filetypes and load plugins based off those types. Also set indent
" based off the filetype.
filetype plugin indent on

" Enable syntax highlighting.
syntax enable


" Sets buffers to be hidden rather than closed. This way, when a new buffer is
" open with `:e` or NerdTree then the current buffer is not forced to be
" saved.
set hidden


" Creates an alias for the save commands since I have a tendency to type a
" capital `w`.
fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
                \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
                \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias("W", "w")
call SetupCommandAlias("Wa", "wa")


" We don't need any of these built-in backup measures or swaps on a modern
" computer.
set nobackup
set nowb
set noswapfile


" Set the shell to Bash since Fish (what I use) isn't POSIX compliant
set shell=bash


" Nord colorscheme configuration
set termguicolors
let g:nord_italic = 1
let g:nord_underline = 1
let g:nord_italic_comments = 1
let g:nord_comment_brightness = 10
let g:nord_uniform_diff_background = 1
colorscheme nord

" column coloring
"highlight ColorColumn ctermbg=235
let &colorcolumn="81"

" Easy window navigation by removing the need for `c-w`.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


" Highlight whitespaces.
set list
set listchars=tab:>•,trail:•,extends:#,nbsp:•


" General tab behavior
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4


" Filetype specific tabs
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype eelixir setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype elixir setlocal ts=2 sts=2 sw=2 expandtab


" No wrapping on VimWiki files
autocmd Filetype vimwiki setlocal nowrap


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
nnoremap <silent> <esc> :noh<cr><esc>

" syntax highlighting
"highlight PreProc cterm=bold ctermfg=2
"highlight Identifier cterm=none ctermfg=3
"highlight Comment cterm=italic ctermfg=4
set background=dark

" tab completion
set wildmode=list:longest,list:full
"function! InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction
"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <S-Tab> <c-n>
