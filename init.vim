if ! exists("mapleader")
  let mapleader = ","
endif

if ! exists("g:mapleader")
  let g:mapleader = ","
endif

" Leader key timeout
set tm=2000

" Allow the normal use of "," by pressing it twice
noremap ,, ,

function! MapEsc(keys, rhs)
    execute 'nmap' a:keys ':update<CR>' . a:rhs
    execute 'vmap' a:keys ':update<CR>' . a:rhs
    execute 'imap' a:keys '<ESC>' . a:rhs . 'i'
    execute 'tmap' a:keys '<ESC>' . a:rhs . 'i'
endfunction

function! MapCO(keys, rhs)
    execute 'nmap' a:keys ':update<CR>' . a:rhs . '<CR>'
    execute 'vmap' a:keys ':update<CR>' . a:rhs . '<CR>'
    execute 'imap' a:keys '<C-o>' . a:rhs . '<CR>'
    execute 'tmap' a:keys '<ESC>' . a:rhs . '<CR>i'
endfunction

" zsh
set shell=zsh

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_extra_conf.py'

call MapCO('<c-_>', ':Commentary')

" General {{{
" Use indentation for folds
set foldmethod=indent
set foldnestmax=5
set foldlevelstart=99
set foldcolumn=0

" Sets how many lines of history VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" Use par for prettier line formatting
set formatprg=par
let $PARINIT = 'rTbgqR B=.,?_A_a Q=_s>|'

" Kill the damned Ex mode.
nnoremap Q <nop>

" Make <c-h> work like <c-h> again (this is a problem with libterm)
if has('nvim')
  nnoremap <BS> <C-w>h
endif

" }}}

" vim-plug {{{

set nocompatible

if has('nvim')
  call plug#begin('~/.config/nvim/bundle')
else
  call plug#begin('~/.vim/bundle')
endif

" Support bundles
Plug 'jgdavey/tslime.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'benekastah/neomake'
Plug 'moll/vim-bbye'
Plug 'vim-scripts/gitignore'
Plug 'vim-syntastic/syntastic'
Plug 'mhinz/vim-startify'

" Git
Plug 'tpope/vim-fugitive'
Plug 'int3/vim-extradite'

" Bars, panels, and files
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-buftabline'

" Text manipulation
Plug 'vim-scripts/Align'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'michaeljsmith/vim-indent-object'
Plug 'easymotion/vim-easymotion'
Plug 'ConradIrwin/vim-bracketed-paste'

" Code completion
Plug 'Sirver/ultisnips'
let g:ultisnips_python_style='google'

" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<CR>"
let g:UltiSnipsJumpBackwardTrigger="<s-CR>"

" Required to make ultisnips and youcompleteme play nice
" Plug 'ervandew/supertab' 
" Plug 'Valloric/YouCompleteMe'
" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" Debuggers
Plug 'idanarye/vim-vebugger'

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'enomsg/vim-haskellConcealPlus', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" Colorscheme
Plug 'vim-scripts/wombat256.vim'

call plug#end()

" }}}

" VIM user interface {{{

" Disable mouse
set mouse=

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu
" Tab-complete files up to longest unambiguous prefix
set wildmode=list:longest,full

" Always show current position
set ruler
set number
set relativenumber

" Show trailing whitespace
set list
" But only interesting whitespace
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
" set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set vb t_vb=

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif
" }}}

" Colors and Fonts {{{

try
  colorscheme wombat256mod
catch
endtry

" Adjust signscolumn to match wombat
hi! link SignColumn LineNr

" Use pleasant but very visible search hilighting
hi Search ctermfg=white ctermbg=173 cterm=none guifg=#ffffff guibg=#e5786d gui=none
hi! link Visual Search

" Match wombat colors in nerd tree
hi Directory guifg=#8ac6f2

" Searing red very visible cursor
hi Cursor guibg=red

" Don't blink normal mode cursor
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkon0

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif
set t_Co=256

" Set utf8 as standard encoding and en_US as the standard language
if !has('nvim')
  " Only set this for vim, since neovim is utf8 as default and setting it
  " causes problems when reloading the .vimrc configuration
  set encoding=utf8
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use powerline fonts for airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline_symbols.space = "\ua0"
" }}}

" Files, backups and undo {{{

" Turn backup off, since most stuff is in Git anyway...
set nobackup
set nowb
set noswapfile

" Source the vimrc file after saving it
augroup sourcing
    autocmd!
    if has('nvim')
        autocmd bufwritepost init.vim source $MYVIMRC
    else
        autocmd bufwritepost .vimrc source $MYVIMRC
    endif
augroup END

" Show undo tree
call MapCO('<leader>u', ':MundoToggle')

nnoremap U :redo<CR>

" Text, tab and indent related {{{

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Copy and paste to os clipboard
call MapEsc('<leader>y', '"*y')
call MapEsc('<leader>p', '"*p')

" }}}

" Visual mode related {{{

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" }}}

" Moving around, tabs, windows and buffers {{{

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk


" Disable highlight when <leader><cr> is pressed
" but preserve cursor coloring
nmap <silent> <leader><cr> :noh\|hi Cursor guibg=red<cr>

" Return to last edit position when opening files (You want this!)
augroup last_edit
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

" close vim
call MapEsc('<leader>q', ':wa<CR>:redir => pwd<CR>:pwd<CR>:redir END<CR>:execute ":SSave " . substitute(substitute(pwd, "\n", "", "g"), "/", "+", "g")<CR>y<ESC>:qa<CR>')

" Fuzzy find files
let g:ctrlp_max_files=0
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](.git|.cabal-sandbox|.stack-work|.idea|.o|.hi|build)$' }

" }}}

" Save on switching to normal mode
inoremap <silent> <ESC> <ESC>:update<CR>
inoremap <silent> <C-o> <C-o>:update<CR><C-o>

let g:startify_session_dir = '~/.config/vim-session'
let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks']
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1

function! InsertTerminal()
    if filereadable(expand(":%p")) == 0
        execute "normal! i"
    endif
endfunction

" Use <Esc> to escape terminal insert mode
tnoremap <Esc> <C-\><C-n>
tmap <c-h> <ESC><C-w>h
tmap <c-j> <ESC><C-w>j
tmap <c-k> <ESC><C-w>k
tmap <c-l> <ESC><C-w>l

nnoremap <c-h> :update<CR><c-w>h
nnoremap <c-j> :update<CR><c-w>j
nnoremap <c-k> :update<CR><c-w>k
nnoremap <c-l> :update<CR><c-w>l
inoremap <c-h> <c-o>:update<CR><c-o><c-w>h
inoremap <c-j> <c-o>:update<CR><c-o><c-w>j
inoremap <c-k> <c-o>:update<CR><c-o><c-w>k
inoremap <c-l> <c-o>:update<CR><c-o><c-w>l

call MapEsc('<leader>r', '<space>output<CR>i<UP><CR><ESC><space><CR>')

" Open various kinds of window splits in each direction
" new, copy, move, terminal, open
call MapEsc('<leader>nh', ':leftabove  vnew<CR>')
call MapEsc('<leader>ch', ':leftabove  vsplit<CR>')
call MapEsc('<leader>mh', ':leftabove  vsplit<CR><C-l>:bh<CR><C-h>')
call MapEsc('<leader>th', ':leftabove  vsplit<CR>:terminal<CR><ESC>:file output<CR>i')
call MapEsc('<leader>oh', ':leftabove  vsplit<CR><leader>oo')

call MapEsc('<leader>nl', ':rightbelow vnew<CR>')
call MapEsc('<leader>cl', ':rightbelow vsplit<CR>')
call MapEsc('<leader>ml', ':rightbelow vsplit<CR><C-h>:bh<CR><C-l>')
call MapEsc('<leader>tl', ':rightbelow vsplit<CR>:terminal<CR><ESC>:file output<CR>i')
call MapEsc('<leader>ol', ':rightbelow vsplit<CR><leader>oo')

call MapEsc('<leader>nk', ':leftabove  new<CR>')
call MapEsc('<leader>ck', ':leftabove  split<CR>')
call MapEsc('<leader>mk', ':leftabove  split<CR><C-j>:bh<CR><C-k>')
call MapEsc('<leader>tk', ':leftabove  split<CR>:terminal<CR><ESC>:file output<CR>i')
call MapEsc('<leader>ok', ':leftabove  split<CR><leader>oo')

call MapEsc('<leader>nj', ':rightbelow new<CR>')
call MapEsc('<leader>cj', ':rightbelow split<CR>')
call MapEsc('<leader>mj', ':rightbelow split<CR><C-k>:bh<CR><C-j>')
call MapEsc('<leader>tj', ':rightbelow split<CR>:terminal<CR><ESC>:file output<CR>i')
call MapEsc('<leader>oj', ':rightbelow split<CR><leader>oo')

nmap <leader>nn :e 
imap <leader>nn <C-o>:e 
call MapEsc('<leader>tt', ':terminal<CR><ESC>:file output<CR>')
nnoremap <leader>oo :CtrlP<CR>
inoremap <leader>oo <ESC>:CtrlP<CR>

" Debugger
call MapCO('<leader>sc', ':VBGcontinue')
call MapCO('<leader>l', ':VBGtoggleBreakpointThisLine')
call MapCO('<leader>si', ':VBGstepIn')
call MapCO('<leader>so', ':VBGstepOut')
call MapCO('<leader>h', ':VBGstepOver')
nmap <leader>e :VBGeval 
imap <leader>e <C-o>:VBGeval 
vmap <leader>e :VBGevalSelectedText<CR>
nmap <leader>x :VBGexecute 
imap <leader>x <C-o>:VBGexecute 
vmap <leader>x :VBGexecuteSelectedText<CR>
nmap <leader>w :VBGrawWrite 
imap <leader>w <C-o>:VBGrawWrite 

map <C-space> za

" don't close buffers when you aren't displaying them
set hidden

" don't close terminal buffers when you aren't displaying them
autocmd TermOpen * set bufhidden=hide
autocmd VimLeave * !~/.config/nvim/onvimexit

" previous buffer, next buffer
call MapCO('<leader>bh', ':bp')
call MapCO('<leader>bl', ':bn')

" maximise
call MapCO('<leader>bm', '<c-w>o')

" close file
call MapCO('<leader>bd', ':Bd!')
" close file and pane
call MapCO('<leader>bc', ':q')

" fuzzy find buffers
noremap <space> :CtrlPBuffer<cr>

" }}}

" Status line {{{

" Always show the status line
set laststatus=2

" }}}

" Editing mappings {{{

" Utility function to delete trailing white space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" }}}

" Helper functions {{{

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" }}}

" NERDTree {{{

" Close nerdtree after a file is selected
let NERDTreeQuitOnOpen = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" If nerd tree is closed, find current file, if open, close it
call MapCO('<leader>f', ':call ToggleFindNerd()')
call MapCO('<leader>F', ':NERDTreeToggle')

" }}}

" Alignment {{{

" Stop Align plugin from forcing its mappings on us
let g:loaded_AlignMapsPlugin=1
" Align on equal signs
call MapCO('<Leader>a=', ':Align =')
" Align on commas
call MapCO('<Leader>a,', ':Align ,')
" Align on pipes
call MapCO('<Leader>a<bar>', ':Align <bar>')
" Prompt for align character
nmap <leader>ap :Align 
imap <leader>ap <c-o>:Align 

" }}}

" Tags {{{

" map <leader>tt :TagbarToggle<CR>

set tags=tags;/
set cst
set csverb

" }}}

" Git {{{

let g:extradite_width = 60
" Hide messy Ggrep output and copen automatically
function! NonintrusiveGitGrep(term)
  execute "copen"
  " Map 't' to open selected item in new tab
  execute "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  execute "silent! Ggrep " . a:term
  execute "redraw!"
endfunction

command! -nargs=1 GGrep call NonintrusiveGitGrep(<q-args>)
call MapCO('<leader>gs', ':Gstatus<CR>')
nmap <leader>gg :copen<CR>:GGrep 
imap <leader>gg <c-o>:copen<CR><c-o>:GGrep 
call MapCO('<leader>gl', ':Extradite!')
call MapCO('<leader>gd', ':Gdiff')
call MapCO('<leader>gb', ':Gblame')

function! CommittedFiles()
  " Clear quickfix list
  let qf_list = []
  " Find files committed in HEAD
  let git_output = system("git diff-tree --no-commit-id --name-only -r HEAD\n")
  for committed_file in split(git_output, "\n")
    let qf_item = {'filename': committed_file}
    call add(qf_list, qf_item)
  endfor
  " Fill quickfix list with them
  call setqflist(qf_list)
endfunction

" Show list of last-committed files
call MapEsc('<leader>g?', ':call CommittedFiles()<CR>:copen<CR>')

" }}}

" Completion {{{
set completeopt+=longest

" Use buffer words as default tab completion
let g:SuperTabDefaultCompletionType = '<c-x><c-p>'

" }}}

" Unmap
autocmd VimEnter * unmap <leader>rwp
autocmd VimEnter * unmap <leader>swp

