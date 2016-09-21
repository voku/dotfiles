"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Lars Moelleken
"       http://moelleken.org - lars@moelleken.org
"
" Codebase:
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version:
"       1.1 - 08/09/14 01:02:30
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Parenthesis/bracket
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Simulate ALT-<key> by mapping escape sequences to key combination. This is
" required for terminals which do not send ALT combinations in 8-bit.
" See http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
" this applies also to cygwin's mintty.
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set ttimeout ttimeoutlen=25 "this is the timeout to distinguish e.g. <A-k> from 'ESC <timeout> k'

" make Vim more useful
set nocompatible

" set the shell
set shell=bash

" Tell vim to use the .vim path first (colors and so)
set runtimepath=~/.vim,$VIMRUNTIME

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file (instead of '\')
let mapleader = ","
let g:mapleader = ","

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Sets how many lines of history VIM has to remember
set history=100

" open 50 tabs max
set tabpagemax=50

if v:version >= 500
  " try reducing the number of lines stored in a register
  set viminfo='500,f1,:100,/100
endif

" optimize for fast terminal connections
set ttyfast

" add the g flag to search/replace by default
set gdefault

" http://stackoverflow.com/questions/16222530/why-do-i-need-vim-in-binary-mode-for-noeol-to-work
"set binary

" don’t add empty newlines at the end of files
"set noeol

" look for embedded modelines at the top of the file
set modeline

" ignore whitespace in vimdiff
if &diff
  set diffopt+=iwhite
endif

" only look at this number of lines for modeline
set modelines=10

" enable filetype detection
filetype on

" enable filetype-specific plugins
filetype plugin on

" enable filetype-specific indenting
filetype indent on

" pasting text unmodified from other applications
" info: auto-complete via <tab> isn't working in INSERT (paste) mode,
"       so you need to switch to INSERT mode via <F2> or use <c-n>
" set paste

" decrease timeout for faster insert with 'O'
set ttimeoutlen=100

" Try to detect file formats.
" Unix for new files and autodetect for the rest.
set fileformats=unix,dos,mac

" automatically re-read files when editted outsite of vim
" set autoread

" use the OS clipboard by default (on versions compiled with `+clipboard`)
"if exists("+clipboard")
"  " here we always use the system-clipboard
"  "set clipboard=unnamedplus
"  set clipboard=unnamed
"endif

" enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" automatically safe files when switchin between them / leaving vim
"set autowriteall
"autocmd FocusLost * silent! :wa
"autocmd TabLeave * silent! :wa

" Disable the splash screen (and some various tweaks for messages).
set shortmess=aTItoO

" tell us about changes
set report=0

" Show the filename in the window titlebar.
if exists("+title")
  set title
endif

" Save files before performing certain actions.
"set autowrite

" Fast saving
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
"command W w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" turn off lazy redraw
set nolazyredraw

" always show all line numbers
"set number

" enhance command-line completion
if exists("+wildmenu")
  set wildmenu
  " type of wildmenu
  set wildmode=longest:full,list:full
endif

" (text) completion settings
set completeopt=longest,menuone

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" allow cursor keys in insert mode
set esckeys

" allow backspace in insert mode
set backspace=indent,eol,start

" toggle for "paste" & "nopaste"
set pastetoggle=<F2>

" enable mouse in all modes
"if exists("+mouse")
"  set mouse=a
"endif

" hide the mouse while typing
"set mousehide

" enable the popup menu
"set mousem=popup

" show “invisible” characters
set lcs=trail:�,tab:��,eol:�,nbsp:�

" free cursor
set whichwrap=b,s,h,l,<,>,[,]

" Ignore case when searching
set ignorecase

" Use intelligent case while searching.
" If search string contains an upper case letter, disable ignorecase.
set smartcase

" Makes search act like search in modern browsers
if exists("+incsearch")
  set incsearch
endif

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" split vertically to the right
set splitright

" split horizontally below
set splitbelow

" don’t reset cursor to start of line when moving around
set nostartofline

" show the cursor position
if exists("+ruler")
  set ruler
endif

" use relative line numbers
"if exists("+relativenumber")
" set relativenumber
" au BufReadPost * set relativenumber
"endif

" Start scrolling at this number of lines from the bottom.
set scrolloff=2

" Start scrolling three lines before the horizontal window border.
set scrolloff=3

" Start scrolling horizontally at this number of columns.
set sidescrolloff=4

" disable line numbers
set nonumber

" no annoying sound on errors
set noerrorbells
"set vb t_vb=""
set visualbell

" no extra margin to the left
set foldcolumn=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show matching brackets when text indicator is over them
set showmatch

" Include angle brackets in matching.
set matchpairs+=<:>

" How many tenths of a second to blink when matching brackets
set mat=2

"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
"
" I have some problems with this :/
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i
"inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  try
    colorscheme molokai
  catch /^Vim\%((\a\+)\)\=:E185/
    " not available
  endtry

  " Visual line marking 80 characters (vim 7.3)
  if v:version >= 703
    set colorcolumn=
  endif

  " Enable coloring for dark background terminals.
  if has('gui_running')
    set background=light
  else
    set background=dark
  endif

  " settings for the molokai-colorscheme
  "let g:rehash256 = 1
  "let g:molokai_original = 1

  " turn on color syntax highlighting
  if exists("+syntax")
    syntax on
    " increases syntax accuracy
    syntax sync fromstart
  endif


  " set to 256 colors
  " set t_Co=256

  " Also switch on highlighting the last used search pattern.
  if exists("+hlsearch")
    set hlsearch
  endif

  " highlight current line
  "if exists("+cursorline")
    "set cursorline
  "endif

  " highlight trailing spaces in annoying red
  if has('autocmd')
    highlight ExtraWhitespace ctermbg=1 guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    if exists('*clearmatches')
      autocmd BufWinLeave * call clearmatches()
    endif
  endif

  " reload .vimrc when updating it
  "if has("autocmd")
  "  autocmd BufWritePost .vimrc nested source %
  "endif

  " highlight conflict markers
  match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

endif

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

" use UTF-8 without BOM
scriptencoding utf-8 nobomb
set termencoding=utf-8 nobomb
set encoding=utf-8 nobomb

" Use Unix as the standard file type
set ffs=unix,dos,mac

" none word dividers
set isk+=_,$,@,%,#,-

" Set font according to system
"if has("mac") || has("macunix")
"  set gfn=Source\ Code\ Pro:h15,Menlo:h15
"elseif has("win16") || has("win32")
"  set gfn=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
"elseif has("linux")
"  set gfn=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
"elseif has("unix")
"  set gfn=Monospace\ 11
"endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keep a backup-file
set backup
if exists("+writebackup")
  set writebackup
  set backupdir=~/.vim/backups
endif

" centralize backups, swapfiles and undo history
set directory=~/.vim/swaps
if exists("+undodir")
  set undodir=~/.vim/undo
endif

" Don't backup files in temp directories or shm
if exists('&backupskip')
  set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
endif

" don't keep swap files in temp directories or shm
if has('autocmd')
  augroup swapskip
    autocmd!
    silent! autocmd BufRead,BufNewFilePre
      \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
      \ setlocal noswapfile
  augroup END
endif

" don't keep undo files in temp directories or shm
if has('persistent_undo') && has('autocmd')
 augroup undoskip
   autocmd!
   silent! autocmd BufWritePre
     \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
     \ setlocal noundofile
  augroup END
endif

" enable vim to remember undo chains between sessions (vim 7.3)
if v:version >= 703
  set undofile
endif

" don't keep viminfo for files in temp directories or shm
if has('viminfo')
  if has('autocmd')
    augroup viminfoskip
      autocmd!
      silent! autocmd BufRead,BufNewFilePre
        \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
        \ setlocal viminfo=
    augroup END
  endif
endif

" disable folding
set nofoldenable

" turn backup off, if most stuff is in SVN, git etc ...
"set nobackup
"set nowritebackup
"set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" expand tabs to spaces
set expandtab

" insert spaces for tabs according to shiftwidth
if exists("+smarttab")
  set smarttab
endif

" does nothing more than copy the indentation from the previous line,
" when starting a new line
" info: if we active this, then we have trouble when we copy paste via mouse
if exists("+autoindent")
  set noautoindent
endif

" automatically inserts one extra level of indentation in some cases
if exists("+smartindent")
  set smartindent
endif

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" number of spaces to use for each step of indent
set shiftwidth=2
set softtabstop=2

" Linebreak on 500 characters
"set lbr
"set tw=500

" wrap at 80 chars by default
"set textwidth=80

" don't automatically wrap on load
" set nowrap

" don't automatically wrap text when typing
set fo-=t

" show “invisible” characters
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
"set list

" support for numbered/bullet lists
set formatoptions+=n

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" allow virtual edit in visual block ..
set virtualedit=block

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gi moves to last insert mode (default)
" gI moves to last modification
nnoremap gI `.

" Movement & wrapped long lines
" This solves the problem that pressing down jumps your cursor 'over' the curren
nnoremap j gj
nnoremap k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
nnoremap <S-Left> :tabprevious<cr>
nnoremap <S-Right> :tabnext<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>

" shortcut to jump to next conflict marker
" WARNING: this isn't working, it prints map-string in files
"nnoremap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
if has('autocmd')
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=[%n]\ %<%f%m%r\ %w\ %y\ \ <%{&fileformat}>\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%=[%b\ 0x%02B]\ [%o]\ %l,%c%V\/%L\ \ %P

" Show current mode in the status line.
if exists("+showmode")
  set showmode
endif

" Show the (partial) command as it’s being typed.
if exists("+showcmd")
  set showcmd
endif


" ---------------------------------------------------------------------------
" File Types
" ---------------------------------------------------------------------------
" automatic commands
if has("autocmd")
  " file type detection

  " Ruby
  au BufRead,BufNewFile *.rb,*.rbw,*.gem,*.gemspec set filetype=ruby

  " Ruby on Rails
  au BufRead,BufNewFile *.builder,*.rxml,*.rjs     set filetype=ruby

  " Rakefile
  au BufRead,BufNewFile [rR]akefile,*.rake         set filetype=ruby

  " Rantfile
  au BufRead,BufNewFile [rR]antfile,*.rant         set filetype=ruby

  " IRB config
  au BufRead,BufNewFile .irbrc,irbrc               set filetype=ruby

  " eRuby
  au BufRead,BufNewFile *.erb,*.rhtml              set filetype=eruby

  " Thorfile
  au BufRead,BufNewFile [tT]horfile,*.thor         set filetype=ruby

  " css - preprocessor
  au BufRead,BufNewFile *.less,*.scss,*.sass       set filetype=css syntax=css

  " markdown
  au BufRead,BufNewFile *.md,*.markdown,*.ronn     set filetype=markdown

  " special text files
  au BufRead,BufNewFile *.rtxt       set filetype=html spell
  au BufRead,BufNewFile *.stxt       set filetype=markdown spell

  au BufRead,BufNewFile *.sql        set filetype=pgsql

  au BufRead,BufNewFile *.rl         set filetype=ragel

  au BufRead,BufNewFile *.svg        set filetype=svg

  au BufRead,BufNewFile *.haml       set filetype=haml

  " aura cmp files
  au BufRead,BufNewFile *.cmp        set filetype=html

  au BufRead,BufNewFile *.json       set filetype=json syntax=javascript

  au BufRead,BufNewFile *.hbs        set syntax=handlebars

  au BufRead,BufNewFile *.mustache   set filetype=mustache

	au BufRead,BufNewFile *.zsh-theme  set filetype=zsh

  au Filetype gitcommit              set tw=68 spell fo+=t
  au Filetype ruby                   set tw=80

  " allow tabs on makefiles
  au FileType make                   setlocal noexpandtab
  au FileType go                     setlocal noexpandtab
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" Yank and put system pasteboard with <Leader>y/p.
noremap <Leader>y "*y
noremap <Leader>Y "*y$
nnoremap <Leader>yy "*yy
noremap <Leader>p "*p
noremap <Leader>P "*P

" select last put
" src: http://vim.wikia.com/wiki/Selecting_your_pasted_text
"nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]

" show current file as HTML (to paste into Keynote)
nmap <Leader>h :TOhtml<CR>:w<cr>:!open %<CR>:q<CR>

" select all
map <Leader>a ggVG

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" copy between different vim sessions
nmap <s-Y> :!echo “”> ~/.vim/tmp<CR><CR>:w! ~/.vim/tmp<CR>
vmap <s-Y> :w! ~/.vim/tmp<CR>
nmap <s-P> :r ~/.vim/tmp<CR>

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" quickfix mappings
map <F7>  :cn<CR>
map <S-F7> :cp<CR>
map <A-F7> :copen<CR>

" emacs movement keybindings in insert mode
imap <C-a> <C-o>0
imap <C-e> <C-o>$
map <C-e> $
map <C-a> 0

" stop opening man pages
nmap K <nop>

" Automatically set paste mode
" https://coderwall.com/p/if9mda
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" stripe whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>sw :call StripWhitespace()<CR>
" save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" multi-purpose tab key (auto-complete)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<Tab>"
  else
    return "\<C-p>"
  endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <s-tab> <C-n>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Strip trailing white space.
function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" call the above function automatically when saving files of certain type.
if has("autocmd")
  autocmd BufWritePre *.py,*.js,*.php,*.gpx,*.rb,*.tpl :call StripTrailingWhitespaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
    call CmdLine("Ack \"" . l:pattern . "\" " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

set ttymouse=xterm2     " necessary for gnu screen & mouse
