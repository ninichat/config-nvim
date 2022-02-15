" ===============
" VIP
" ===============

let mapleader = ","
colorscheme peaksea

call plug#begin()
" Fzf file finder
Plug 'junegunn/fzf.vim'
Plug 'glench/vim-jinja2-syntax'
Plug 'dense-analysis/ale'
call plug#end()

" ===============
" Base
" ===============

" Autocompletion: ignore cache files
set wildmenu
set wildignore=*.o,*.pyc,*/.git/*

" Shift line number for current line
set number

set relativenumber
set cmdheight=2

" Show tabs, trailing, and non breakable spaces by defaults
set list

" Don't put two spaces when joining
set nojoinspaces

" Ignore unsaved changes when switching buffers
set hidden

" Show matching brackets on cursor, blink 2 tenths of seconds
set showmatch
set matchtime=2

" Other format of status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" =============
" Tabs stuff
" =============
set expandtab
set smarttab

" spaces a tab count
set shiftwidth=4

" spaces a tab produces
set tabstop=4

" round ident to multiple of shiftwidth
set shiftround

" auto indent new lines
set smartindent

" ### Folding
set foldenable
" indent => fold level
set foldmethod=indent
set foldnestmax=10
set foldlevelstart=10

" ### Buffers
" Behavior on switching buffers
set switchbuf=useopen,usetab,newtab

" =============================
" Text rendering
" =============================

set linebreak
set textwidth=80
set scrolloff=5

" Set temporary backup
set nobackup

" don't redraw while executing scripts
set lazyredraw

" Keep undos stored
set undofile

" Delete trailing white space on save
autocmd BufWritePre * %s/\s\+$//e

" Ignore search case when there is no uppercase
set smartcase
set ignorecase

" ==================
" Mappings
" ==================

nmap Y y$
inoremap jk <esc>

if exists("yankstack_yank_keys")
  call yankstack#setup()
endif

" Disable highlight - enter
map <silent> <cr> :noh<cr>

" Special SPICY stuff
map <leader>r :read !

nmap <space> :Files<cr>
nmap <leader>f :Files<cr>
nmap <leader>e :Buffers<cr>
nmap <leader>a :Ag<cr>

" Easier way to move around windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close current buf, all buf
map <leader>bd :bd<cr>
map <leader>ba :bufdo bd<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Open new tab / close all tabs except current / close current
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Fast edit vimrc
map <leader>vrc :e! ~/.config/nvim/init.vim<cr>
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim


" =====================
" Helpers
" =====================

" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction

" ### ack.vim
" Use the the_silver_searcher
let g:ackprg = 'ag --vimgrep'

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ack, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" ### Python
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
" highlight python keywords
au FileType python syn keyword pythonDecorator True None False self

" ### Shell
if exists('$TMUX')
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color
    endif
endif
