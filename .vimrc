" vim:set foldmethod=marker:

" NeoBundle {{{
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'bling/vim-airline'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'Align'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jceb/vim-hier'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle "motemen/vim-guess-abbrev"
NeoBundle 'majutsushi/tagbar'

filetype plugin indent on " Required for NeoBundle

" }}}

" Basic Configuration {{{

set nocompatible
set backspace=indent,eol,start

set nobackup
set viminfo=!,'50,<1000,s100,\"50 "
set history=100 
set ruler

" 補完時に無視されるファイル名のsuffix
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

syntax on

" 色の設定
set t_Co=256
set t_Sf=[3%dm
set t_Sb=[4%dm

set background=dark
colorscheme hybrid

" 補完候補の色づけ
hi Pmenu ctermfg=Black
hi Pmenu ctermbg=Gray
hi PmenuSel ctermfg=Black
hi PmenuSel ctermbg=Cyan
hi PmenuSbar ctermfg=White
hi PmenuSbar ctermbg=DarkGray

set number

set modelines=1

" タブ幅の設定
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

"インデントの設定
set autoindent
set smartindent
set cindent

"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase

"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

"検索時に最後まで行ったら最初に戻る
set wrapscan

"検索文字列入力時に順次対象文字列にヒットさせる
set incsearch

"入力中のコマンドをステータスに表示する
set showcmd

"括弧入力時の対応する括弧を表示
set showmatch

"検索結果文字列のハイライトを有効にする
set hlsearch

"ステータスラインを常に表示
set laststatus=2

" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu

" コマンドライン補間をシェルっぽく
set wildmode=list:longest

" バッファが編集中でもその他のファイルを開けるように
set hidden

" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread

" Whitespaceを表示
set listchars=tab:>-,trail:_
set list

" undoの設定
set undofile
set undodir=/Users/yohei/.vim/undodir/

" 文字コードの自動認識
" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
set encoding=utf-8
set fileencoding=utf-8
if &encoding !=# 'utf-8' " utf-8をデフォルトに
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("¥x87¥x64¥x87¥x6a", 'cp932', 'eucjp-ms') ==# "¥xad¥xc5¥xad¥xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("¥x87¥x64¥x87¥x6a", 'cp932', 'euc-jisx0213') ==# "¥xad¥xc5¥xad¥xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^¥(euc-jp¥|euc-jisx0213¥|eucjp-ms¥)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  let &fileencodings = 'utf-8' . ',' . &fileencodings " XXX: adhocな対応
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^¥x01-¥x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double

" set tags
set tags=tags,./tags

" 辞書ファイルからの単語補間
set complete+=k
" }}}

" Commands {{{

let mapleader = ","

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

noremap <unique> <Leader>w :<C-u>update<CR>
noremap <unique> <silent> <Leader>n :bn<CR>
noremap <unique> <silent> <Leader>p :bp<CR>
noremap <unique> <silent> <Leader>d :bd<CR>

"" commentout {{{

" lhs comments
vnoremap <unique> <silent> ,# :s/^/#/<CR>:nohlsearch<CR>
vnoremap <unique> <silent> ,/ :s/^/\/\//<CR>:nohlsearch<CR>
vnoremap <unique> <silent> ," :s/^/\"/<CR>:nohlsearch<CR>
vnoremap <unique> <silent> ,% :s/^/%/<CR>:nohlsearch<CR>
vnoremap <unique> <silent> ,; :s/^/;/<CR>:nohlsearch<CR>
vnoremap <unique> <silent> ,- :s/^/--/<CR>:nohlsearch<CR>
vnoremap <unique> <silent> ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

"" }}}

" }}}

" Plugin Setting {{{

"" Align {{{
let g:DrChipTopLvlMenu = ""
"" }}}

"" ctrlp {{{
let g:ctrlp_extensions = ['mixed', 'quickfix']
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_switch_buffer = '0'
"" }}}

"" vim-indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
"}}}

"" fakeclip {{{

" Macのクリップボードをペースト
nmap <unique> <silent> <Leader>v <Plug>(fakeclip-p)
vmap <unique> <silent> <Leader>v <Plug>(fakeclip-p)
nmap <unique> <silent> <Leader>y <Plug>(fakeclip-y)
vmap <unique> <silent> <Leader>y <Plug>(fakeclip-y)

"" }}}

"" airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'
"" }}}

"" neocomplepop {{{


let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 5
let g:neocomplcache_min_keyword_length = 5
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"" }}}

"" neosnippet {{{

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#snippets_directory = "~/.vim/snippets"

"" }}}

"" vim-hier {{{
let g:hier_enabled = 1
"" }}}

"" quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config['watchdogs_checker/_'] = {
      \   'outputter/quickfix/open_cmd' : '',
      \   'hook/hier_update/enable_exit' : 1,
      \   'runner/vimproc/updatetime' : 40,
      \ }


"" }}}

"" watchdog {{{
let g:watchdogs_check_BufWritePost_enable = 1
"" }}}

"" fugitive {{{

noremap <unique> <Leader>gs :<C-u>Gstatus<CR>
noremap <unique> <Leader>gd :<C-u>Gdiff<CR>
noremap <unique> <Leader>gb :<C-u>Gblame<CR>
noremap <unique> <Leader>ga :<C-u>Gwrite<CR>
noremap <unique> <Leader>gc :<C-u>Gcommit<CR>

"" }}}



" }}}

