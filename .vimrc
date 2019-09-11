" backspaceで文字削除
noremap! <C-?> <C-h>

" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" シンタックスハイライト
syntax on

" 256色
set t_Co=256

" 文字コードをUFT-8に設定
set fenc=utf-8
set encoding=UTF-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>


"tab-------------------------------------

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap [TABCMD]  <nop>
nmap     t [TABCMD]
map <silent> [TABCMD]n :tabnext<cr>
map <silent> [TABCMD]N :tabNext<cr>
map <silent> [TABCMD]p :tabprevious<cr>
map <silent> [TABCMD]c :tablast <bar> tabnew<cr>
map <silent> [TABCMD]x :tabclose<cr>

" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [TABCMD]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor


"tag-------------------------------------
set tags+=.tags;$HOME
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 
" F8キーでtagbar起動
nmap <F8> :TagbarToggle<CR>


"NERDTree--------------------------------
map nd :NERDTreeToggle<CR>

" ファイル名が指定されてvimが起動した場合はNERDTreeは表示しない
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" デフォルトでツリー表示
"function s:MoveToFileAtStart()
"  call feedkeys("\<c-w>")
"  call feedkeys("\l")
"endfunction
"autocmd VimEnter * execute 'NERDTree' | call s:MoveToFileAtStart()
set guifont=DroidSansMono\ 12


"vim-airline-----------------------------
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '|'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" Powerline系フォントを利用する
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme = 'deus'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif


"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/shigeo/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/shigeo/.vim/bundles')
  call dein#begin('/home/shigeo/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('/home/shigeo/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('scrooloose/nerdtree')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-repeat')
  call dein#add('w0rp/ale')
  call dein#add('majutsushi/tagbar')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('vim-jp/vimdoc-ja')
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

