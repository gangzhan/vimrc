" ###########################################################
" # File Name     : init-basic.vim
" # Author        : Mou Tong
" # Email         : mou.tong@qq.com
" # Created Time  : 2018-01-26 08:00
" # Last Modified : 2020-05-24 12:55
" # By            : Mou Tong
" # Description   : basic config for vim
" ###########################################################

" Environment - Encoding, Indent, Fold {{{ "

if version >= 800 && !has('nvim')
    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
elseif !has('nvim')
    set nocompatible " Vi IMproved
    filetype plugin indent on " Enable filetype plugins
endif

if !isdirectory(expand("~/.vim/"))
    call mkdir($HOME . "/.vim")
endif

set title
set ttyfast " Improves smoothness of redrawing

" Don't redraw while executing macros (good performance config)
set lazyredraw

" No annoying sound on errors
set belloff=all
set t_vb=
set tm=500

" Configure backspace so it acts as it should act
set backspace=indent,eol,start

let $user_name  = "dalu"
let $tuser_name = "Mou Tong"
let $user_email = "mou.tong@qq.com"

" Set utf8 as standard encoding
set encoding=utf-8
set fileencodings=utf-8,gb18030,gb2312,default,cp936,big5,latin1

" Use Unix as the standard file type
set fileformats=unix,mac,dos

" Also break at a multi-byte character above 255
set formatoptions+=m
" When joining lines, don't insert a space between two multi-byte characters
set formatoptions+=B
" Where it makes sense, remove a comment leader when joining lines
set formatoptions+=j
" When formatting text, recognize numbered lists
set formatoptions+=n

set autoindent " Auto indent
set smartindent " Smart indent

" N spaces for every indent
set shiftwidth=4

" 1 tab == N spaces
set tabstop=4

" perform N spaces when edit
set softtabstop=4

" Use space instead of tabs
set expandtab

" Add `shiftwidth' spaces or `tabstop' spaces when <Tab>
set smarttab

" Popup confirm when edit unsave or readonly files
set confirm

" Enable clipboard if possible
if has('clipboard')
    if has('unnameplus') " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else " On macOS and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" set iskeyword+=-
set whichwrap+=<,>,h,l,[,]

" Enable mouse in terminal
set mouse=a

" Clear vert split and empty line fillchar
set fillchars=vert:│,fold:·

" Use these symbols for invisible chars
if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,eol:¬,trail:⋅,extends:»,precedes:«,nbsp:+
endif

" Fold code config
set foldenable
set foldmethod=marker

" }}} Environment - Encoding, Indent, Fold "

" Appearence - Scrollbar, Highlight, Numberline {{{ "

" Enable syntax highlighting
syntax enable
syntax on

" set vim colors
" use true colors in vim under tmux
" @ https://github.com/tmux/tmux/issues/1246
" @ https://github.com/vim/vim/issues/993#issuecomment-255651605
if has("termguicolors") && !has('nvim')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors " use 24-bit colors
elseif has('nvim')
    set termguicolors " use 24-bit colors
else
    set t_Co=256 " Using 256 colors
endif

" Abbrev of prompt
set shortmess=aoOtTF

" Hide mouse pointer when type
set mousehide

" Always show current position
set ruler

" Highlight chars when over 80 rows
" augroup vimrc_autocmds
   " autocmd BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
   " autocmd BufEnter * match OverLength /\%81v.*/

" show command in the last line of screen
set showcmd

" Height of the command bar
set cmdheight=1

" Turn on the Wild menu
" Enhance command-line completion
set wildmenu
set wildmode=list:longest,full

" Ignore compiled files
set wildignore=*.so,*.swp,*.pyc,*.pyo,*.exe,*.7z

if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*,*\desktop.ini
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

" }}} Appearance - Scrollbar, Highlight, Numberline "

" Edit - Navigation, History, Search {{{ "

" For regular expressions turn magic on
set magic

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Update preview instantly when searching
set incsearch

" Don't wrap around when junping between search result
set nowrapscan

" session config
set sessionoptions-=options " do not store global and local values in a session
set sessionoptions-=folds " do not store folds

" function - restore last session {{{ "

function! MakeSession(overwrite)
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  if a:overwrite == 0 && !empty(glob(b:filename))
    return
  endif
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
  au VimLeave * :call MakeSession(1)
else
  au VimLeave * :call MakeSession(0)
endif

" }}} function - restore last session "

" Set to auto read when a file is changed from the outside
set autoread

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" Automatically write a file after milliseconds nothing is typed
" Will get bad experience for diagnostics when it's default 4000
set updatetime=300

" Sets how many lines of history VIM has to remember
set history=1000 " command line history

" Turn backup off, since most stuff is in git et.c anyway...
" And plugins demand such as `coc`...
set nobackup
set nowritebackup

" Swap files are necessary when crash recovery
set directory=$HOME/.vim/swapfiles/

" Turn persistent undo on,
" means that you can undo even when you close a buffer/VIM
if has('persistent_undo')
    set undodir=$HOME/.vim/undotree/
    set undofile
    set undolevels=1000
endif

" Ctags config
if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" Netrw config
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
autocmd FileType netrw setlocal bufhidden=delete

" Make auto-complete faster
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags

" }}} Edit - Navigation, History, Search "

" Buffer - BufferSwitch, FileExplorer, Statusline {{{ "

" execute `:argdo' etc. by omitting `!'
set hidden

" Specify the behavior when switching between buffers
set switchbuf=useopen
set showtabline=1
set tabpagemax=50

set splitright " Puts new vsplit windows to the right of the current
set splitbelow " Puts new split windows to the bottom of the current

" Split management
nmap <silent> <M-J> :exe "resize " . (winheight(0) * 3/2)<CR>
nmap <silent> <M-K> :exe "resize " . (winheight(0) * 2/3)<CR>
nmap <silent> <M-H> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nmap <silent> <M-L> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Window change
nmap <silent> <M-j> <C-w>j
nmap <silent> <M-k> <C-w>k
nmap <silent> <M-h> <C-w>h
nmap <silent> <M-l> <C-w>l

" 0 means never show, 1 means show only if there are at least two windows
" 2 means always show
set laststatus=2
set statusline=%<%f\ " filename
set statusline+=%w%h%m%r " option
set statusline+=\ [%{&ff}]/%y " fileformat/filetype
set statusline+=\ [%{getcwd()}] " current dir
set statusline+=\ [%{&encoding}] " encoding
set statusline+=%=%-14.(%l/%L,%c%V%)\ %p%% " Right aligned file nav info

" }}} Buffer - BufferSwitch, FileExplorer, StatusLine "

" Keybindings {{{ "

" Map jk to enter normal mode
imap jk <Esc>

" Enhance <C-l>
nnoremap <silent> <C-l> :<C-u>nohlsearch<C-R>=has('diff')?'<BAR>diffupdate':''<CR><CR>:syntax sync fromstart<CR><C-l>

" Make `&' keep the flags in substitute
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Use `%%' to expand current file's dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Enhace `*' {{{ "

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
if maparg('<leader>*', 'n') == ''
  nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
endif
if maparg('<leader>*', 'v') == ''
  vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>
endif

" }}} Enhace `*' "

" LeaderKey {{{ "

" With a map leader it's possible to do extra key combinations
let mapleader = ","

" Use `\' to replace `,' since `,' is leaderkey
noremap \ ,

" Fast saving
nnoremap <silent> <Leader>w :update<CR>

" Fast editing and reloading of vimrc configs
nnoremap <Leader>ec :e! ~/.vim/config<CR>
nnoremap <Leader>er :source ~/.vimrc<CR>

" Switch CWD to the directory of the open buffer
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Edit macros
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Key Mappings - Buffer {{{ "

" Close the current buffer
map <Leader>bd :bdelete<CR>

" Close all the buffers
map <Leader>ba :bufdo bd<CR>

" Change buffers
map <Leader>l :bnext<CR>
map <Leader>h :bprevious<CR>

" }}} Key Mappings - Buffer "

" Key Mappings - Tab {{{ "

map <Leader>tn :tabnew<CR>
map <Leader>to :tabonly<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove

" Let 'tl' toggle between this and the last accessed tab
let b:lasttab = 1
nmap <Leader>tl :exe "tabn ".b:lasttab<CR>
au TabLeave * let b:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
map <Leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" }}} Key Mappings - Tab "

" }}} LeaderKey

" }}} Keybindings "

" Package opt {{{ "

if has('packages')

    " Enhance `%' command
    packadd! matchit
    autocmd FileType python let b:match_words = '\<if\>:\<elif\>:\<else\>'

    " when editing a file that is already edited with another Vim instance
    " go to that Vim instance
    if !has('nvim')
        packadd! editexisting
    endif

else

    runtime macros/matchit.vim
    autocmd FileType python let b:match_words = '\<if\>:\<elif\>:\<else\>'

    if !has('nvim')
        runtime macros/editexisting.vim
    endif

endif

" }}} Package opt "

" GUI Related {{{ "

" set cursor shape
if has ('nvim') || has('gui_running')
    set guicursor=n-v-sm:block
    set guicursor+=i-c-ci:ver25
    set guicursor+=ve-r-cr-o:hor20
    set guicursor+=a:blinkon0 " no cursor blink
else
    " Cursor Shape
    " SI = INSERT mode
    " SR = REPLACE mode
    " EI = NORMAL mode (ELSE)
    " Cursor settings:
    " 1 -> blinking block
    " 2 -> solid block
    " 3 -> blinking underscore
    " 4 -> solid underscore
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
    " NOTE the value can be different in different terminals
    " @ https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
    if $TERM_PROGRAM =~ "iTerm.app"
        if empty($TMUX)
            let &t_SI .= "\<Esc>]50;CursorShape=1\x7"
            let &t_SR .= "\<Esc>]50;CursorShape=2\x7"
            let &t_EI .= "\<Esc>]50;CursorShape=0\x7"
        else
            let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
            let &t_SR .= "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
            let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        endif
    else
        let &t_SI .= "\e[5 q"
        let &t_SR .= "\e[4 q"
        let &t_EI .= "\e[1 q"
    endif
endif

if has('gui_running')
    " set gui font
    " set guifont=Sarasa\ Mono\ SC:h12

    " change gui font size
    command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
    command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')

    " show table numbers
    set guitablabel=%N:%M%t

    " disable scrollbars
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=T " Also disable toolbar
endif

" }}} GUI Releated "

" Neovim Related {{{ "

" Enable to continue where you left
if has('nvim')
    set shada=!,'100,<50,s10,h
else
    set viminfo='100,s10,<50,n$HOME/.vim/viminfo
endif

" add mouse support to nvim
if !has('nvim')
    set ttymouse=xterm2
endif

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

" tabline. Replaced by `guitablabel' when GUI is running
if has('nvim')
else
    set tabline=%N:%M%t
endif

" call pyenv when using neovim
if has("nvim")
    let g:python_host_prog  = $HOME . "/.pyenv/versions/neovim2/bin/python"
    let g:python3_host_prog = $HOME . "/.pyenv/versions/neovim3/bin/python"
endif

" }}} Neovim Related "

" Misc {{{ "

" vertical diffsplit
set diffopt+=vertical

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" Define how to use the CTRL-A and CTRL-X commands for adding to and subtracting from a number respectively
set nrformats-=octal

augroup dalu_color_warning
    autocmd!
    " ColorScheme means to match keywords after loading a color scheme
    " Syntax means to match keywords when the `syntax` option has been set
    " More details can be checked by `:help autocmd`
    autocmd ColorScheme * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|BUG\|HACK\|XXX\|NOTICE\|WARNING\|DANGER\|DEPRECATED\|REVIEW\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\)')
augroup END

" }}} Misc "