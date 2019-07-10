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

" 文字コードをUFT-8に設定
set fenc=utf-8
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

" デフォルトでツリー表示
function s:MoveToFileAtStart()
  call feedkeys("\<c-w>")
  call feedkeys("\l")
endfunction
autocmd VimEnter * execute 'NERDTree' | call s:MoveToFileAtStart()

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
  "call dein#add('ryanoasis/vim-devicons')
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

