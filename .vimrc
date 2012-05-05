set nocompatible
set encoding=utf-8
scriptencoding utf-8

" Load Pathogen
filetype on " fix vim exit badness
filetype off
let g:pathogen_disabled = ['pathogen'] " prevent pathogen from self-sourcing
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Change map leader to ,
let mapleader=","

set hidden " Preserve closed buffers

set tw=78 " width of 78
set ts=2  " tab of 2
set sw=2  " shift of 2
set showmatch " matching parentheses
set ignorecase
set smartcase " all lower case means case insensitive search
set hlsearch
set incsearch
" clear search with leader+space
nnoremap <leader><space> :noh<cr>
"set colorcolumn=80
set showmode
" in insert mode, got to normal mode with jj
inoremap jj <Esc>
" in normal mode, run current file with leader.
nnoremap <leader>. :!./%<cr>
" in normal mode insert current file name with leaderf
nnoremap <leader>f :read !ls %<cr>kJ
" open ~/.reminders with leaderr
nnoremap <leader>r :e ~/.reminders<cr>
" open vimrc with leaderv
nnoremap <leader>v :e ~/.vimrc<cr>

set history=1000
set undolevels=1000
set title
set visualbell

set nobackup
set noswapfile

set fdm=indent " fold on indent

autocmd filetype ruby set expandtab
autocmd filetype javascript set expandtab

autocmd filetype mail set tw=72

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

" nomal regex format
nnoremap / /\v
vnoremap / /\v


set tags=~/.tags
" removed from default: mgTt
set guioptions=aceirL

set autoindent " auto-indent
set copyindent " copy from previous line when indenting

" window fun
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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

" macro j: package and public class declarations.
autocmd filetype java let @j=':read !echo %^v3f/x$F/spublic class f.Do{}ggIpackage J:s!/!.!gA;GO'
" macro i: import last typed class name (without package).
autocmd filetype java let @i='viwyggoimport pa;bi'

" aliases for java
autocmd filetype java ab ifb if<Space>()<CR>{<CR>}<esc>kk$i
autocmd filetype java ab psf private<Space>static<Space>final
autocmd filetype java ab psfS private<Space>static<Space>final<Space>String
autocmd filetype java ab pf private<Space>final
autocmd filetype java ab pfS private<Space>final<Space>String
autocmd filetype java ab pfi private<Space>final<Space>int
autocmd filetype java ab println System.out.println("");<esc>hhi

" relative number fun
set rnu
autocmd InsertEnter * :set nornu
autocmd InsertLeave * :set rnu

if has('mac')
	set gfn=Monaco
endif


" twitter
if has('ruby')
	ruby require 'rubygems'
	ruby require 'vim-twitter'
endif

nnoremap <leader>t :set filetype=tweet<CR>
autocmd filetype tweet set textwidth=0
autocmd filetype tweet nnoremap <leader>p V"ty:Tweet t<backspace>

syn on
