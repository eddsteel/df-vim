set nocompatible
set encoding=utf-8
scriptencoding utf-8

"  Go away help {{{1
nmap <F1> <Esc>
imap <F1> <Esc>


" Load neobundle {{{1
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/bundle/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim', {'name': 'bundle'}
source ~/.vim/bundle/.manifest

filetype plugin indent on
NeoBundleCheck

" Change map leader to , {{{1
let mapleader=","

set hidden " Preserve closed buffers
set wildmode=list:longest " auto-complete like shell

set tw=78 " width of 78
set ts=2  " tab of 2
set sw=2  " shift of 2
set showmatch " matching parentheses
set ignorecase
set smartcase " all lower case means case insensitive search
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set title
set visualbell
set fdm=indent " fold on indent
set foldlevel=10 " but don't start folded.

set nobackup
set noswapfile

" clear search with leader+space
nnoremap <leader><space> :noh<cr>
set colorcolumn=78
set showmode
" in normal mode, source current file with leader,
nnoremap <leader>, :so %<cr>
" in normal mode, run current file with leader. " :!./%<cr>
nnoremap <leader>. :QuickRun<cr>
vnoremap <leader>. :QuickRun<cr>

" in normal mode insert current file name with leaderf
nnoremap <leader>f "%p
" open ~/.reminders with leaderr
nnoremap <leader>r :execute "edit ~/.org/schedule.rem"
" open vimrc with leaderv
nnoremap <leader>v :e ~/.vimrc<cr>

" Markdown-style headings
nnoremap <leader>- yypVr-
nnoremap <leader>= yypVr=


autocmd filetype ruby set expandtab
autocmd filetype javascript set expandtab

autocmd filetype mail set tw=72
autocmd filetype mail set colorcolumn=72

autocmd filetype haskell setlocal include=^import 
autocmd filetype haskell setlocal includeexpr=substitute(substitute(v:fname,'\\.','/','g'),'$','.hs','')

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

set t_Co=256
colorscheme vimbrant

set list
set listchars=tab:→\ ,extends:»,precedes:«,trail:·,nbsp:·


" get 7.3: set relativenumber
set termencoding=utf-8
set encoding=utf-8

" sudo write
cmap w!! w !sudo tee % >/dev/null

" see command line history
nnoremap !! :!<CR>

" nomal regex format
nnoremap / /\v
vnoremap / /\v


set tags=./tags,../tags,tags,~/Projects/tags
" removed from default: mgTt
set guioptions=aceirL

set autoindent " auto-indent
set copyindent " copy from previous line when indenting

" window fun
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-w>\| <C-w>v<C-w>l

map <Leader>x :set filetype=xml<CR>
  \:source $VIMRUNTIME/syntax/xml.vim<CR>
  \:set foldmethod=syntax<CR>
  \:source $VIMRUNTIME/syntax/syntax.vim<CR>
  \:inoremap \> ><CR>
  \:echo "XML mode is on"<CR>

vmap <Leader>px !xmllint --format -<CR>
nmap <Leader>px !!xmllint --format -<CR>
nmap <Leader>pxa :%!xmllint --format -<CR>

nmap <Leader>i :%!xsltlint<CR>

autocmd filetype java setlocal keywordprg="" " use vimhelp

if has('mac')
	set gfn=Monaco
endif

" Git
cab gc Gcommit
cab gs Gstatus
cab gd Gdiff
cab gw Gwrite
cab gr Gread
cab dg diffget
cab dp diffput
cab dt diffthis

" notes
let g:notes_directories = ['~/.org/project-support']
let g:notes_suffix = '.txt' " otherwise my phone doesn't want to read them.

" nerdtree
cab nt NERDTreeToggle

"wtf happened to my modelines?
set modelines=2

" Rainbow parens {{{1
" rainbow pairs (vimbrant-y)
"let g:rbpt_colorpairs = [
"\ [15, 'White'],
"\ [118, 'RoyalBlue3'],
"\ [197, 'SeaGreen3'],
"\ [208, 'DarkOrchid3'],
"\ [123,  'firebrick3'],
"\ [135, 'RoyalBlue3'],
"\ [98, 'SeaGreen3'],
"\ [225, 'DarkOrchid3'],
"\ [161, 'firebrick3'],
"\ [85,  'RoyalBlue3'],
"\ [244, 'SeaGreen3'],
"\ [118, 'DarkOrchid3'],
"\ [197, 'firebrick3'],
"\ [208, 'RoyalBlue3'],
"\ [118, 'SeaGreen3'],
"\ [197, 'DarkOrchid3'],
"\ ]

" rainbow pairs (monochrome-y)
let g:rbpt_max = 9
let g:rbpt_colorpairs = [
	\ [235, 'SeaGreen3'],
	\ [236, 'firebrick3'],
	\ [237, 'DarkOrchid3'],
	\ [239, 'SeaGreen3'],
	\ [242, 'RoyalBlue3'],
	\ [245, 'firebrick3'],
	\ [248, 'DarkOrchid3'],
	\ [250, 'RoyalBlue3'],
	\ [255, 'White'],
	\ ]

nnoremap <leader>b :RainbowParenthesesLoadBraces<cr>
nnoremap <leader>p :RainbowParenthesesLoadRound<cr>
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


"Powerline {{{1
set laststatus=2
let g:Powerline_symbols = 'fancy'

" Steal Uji's space idea {{{1
nnoremap <space>C zC
nnoremap <space>D :<c-u>Dispatch<cr>
nnoremap <space>F :<c-u>find<space>**/
nnoremap <space>K :stag<space>
nnoremap <space>M zM
nnoremap <space>O zO
nnoremap <space>R zR
nnoremap <space>T :NERDTreeFind<cr>
nnoremap <space>U vU
nnoremap <space>V :<c-u>VimShellCreate -split -splitcommand=split<Cr>


nnoremap <space>a :<c-u>!~/bin/tag-dir .<cr><cr>
nnoremap <space>b :cf<cr>
nnoremap <space>c zc
nnoremap <space>e :<c-u>edit<space>
nnoremap <space>f :<c-u>set foldlevel=
nnoremap <space>gs :<c-u>Gstatus<cr>
nnoremap <space>gd :<c-u>Gdiff<cr>
nnoremap <space>gb :<c-u>Gblame<cr>
nnoremap <space>gl :<c-u>Glog<cr>
nnoremap <space>h <c-w>h
nnoremap <space>i :cw<cr>
nnoremap <space>j <c-f>
nnoremap <space>k <c-b>
nnoremap <space>l <c-w>l
nnoremap <space>m :<c-u>Make<cr>
nnoremap <space>o zo
nnoremap <space>q :<c-u>quit<cr>
nnoremap <space>s :<c-u>vert<space>stag<space>
nnoremap <space>t :<c-u>tag<space>
nnoremap <space>u vu
nnoremap <space>v <c-w>v
nnoremap <space>w :<c-u>write<cr>
nnoremap <space>x :<c-u>x<cr>
nnoremap <space>? :<c-u>he<space>

vnoremap <space>s :<c-u>sort<cr>
vnoremap <space>/ :s/


" Other finger-savers {{{1
inoremap jj <Esc>
nnoremap <space><space> :
vnoremap <space><space> :
" this needs to be set in terminal emulator.
" iterm has gui for it, hopefully vte has something
map  <Esc>[?1;32~ <C-'>
map! <Esc>[?1;32~ <C-'>
inoremap <C-'> <Esc>:w<cr>a
nnoremap <C-'> :w<cr>
vnoremap <C-'> <Esc>:w<cr>a


"come on. {{{1
set cm=blowfish

" vimshell stuff {{{1
let g:vimshell_right_prompt = 'fnamemodify(getcwd(), "~")'
let g:vimshell_prompt = '% '
let g:vimshell_split_command = 'botright 12 split'

autocmd FileType int-* setlocal laststatus=0

"Digraphorific {{1
digraph oo 176

"NeoComplete {{{1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
" Scala {{1
autocmd filetype scala set keywordprg="" " use vimhelp

augroup vimrc_scala
  autocmd!
  autocmd FileType scala call s:vimrc_scala()
  "autocmd FileType scala nnoremap <buffer> <Space>r :<C-u>StartSBT
  autocmd FileType scala setlocal et
  autocmd FileType scala setlocal sw=2
  autocmd FileType scala setlocal ts=8
  autocmd FileType scala set makeprg=sbt\ compile
  autocmd FileType scala set errorfile=target/quickfix/sbt.quickfix
  autocmd FileType scala set efm=%E\ %#[error]\ %f:%l:\ %m,%C\ %#[error]\ %p^,%-C%.%#,%Z,
         \%W\ %#[warn]\ %f:%l:\ %m,%C\ %#[warn]\ %p^,%-C%.%#,%Z,
         \%-G%.%#
augroup END
" scala sbt interaction {{{1
command! -nargs=0 StartScalaRepl execute 'VimShellInteractive scala | let t:sbt_bufname = bufname('%')
command! -nargs=0 StartSBT execute 'VimShellInteractive sbt' | let t:sbt_bufname = bufname('%')

function! s:sbt_run()
  let cmds = get(t:, 'sbt_cmds', 'compile')

  let sbt_bufname = get(t:, 'sbt_bufname')
  if sbt_bufname !=# ''
    call vimshell#interactive#set_send_buffer(sbt_bufname)
    call vimshell#interactive#send(cmds)
  else
    echoerr 'try StartSBT'
  endif
endfunction

function! s:vimrc_scala()

endfunction

" clojure {{{1
let vimclojure#FuzzyIndent=1
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = "/usr/local/bin/ng"


" Paredit
" let g:paredit_mode = 0

" Unite

nnoremap <C-p> :<C-u>Unite file_rec/async -input=src\  -start-insert -toggle -buffer-name=file -immediately<cr>
nnoremap <space>/ :<C-u>Unite grep:src -quick-match -immediately -toggle -buffer-name=grep<cr>
nnoremap <space>F :<C-u>Unite grep:.::<C-r><C-w><CR>



syn on


" vim: set foldmethod=marker :
