" vim:set foldmethod=marker:

" NeoBundle {{{
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'reedes/vim-colors-pencil'
NeoBundle '29decibel/codeschool-vim-theme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'vim-scripts/pyte'

NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'bling/vim-airline'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'godlygeek/tabular'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle "osyo-manga/vim-watchdogs"
NeoBundle 'jceb/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle "motemen/vim-guess-abbrev"
NeoBundle 'majutsushi/tagbar'

NeoBundle 'mileszs/ack.vim'
NeoBundle 'mbbill/undotree'
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'vim-perl/vim-perl'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'derekwyatt/vim-sbt'
NeoBundle 'motemen/vim-help-random'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'sgur/unite-qf'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'sgur/unite-git_grep'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'Shougo/unite-outline'

filetype plugin indent on " Required for NeoBundle

" }}}

" Other Plugin Loading {{{
if $GOROOT != ''
    set rtp+=$GOROOT/misc/vim
endif

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

" 文字コード
set encoding=utf-8
" fileencoding については自動認識してもらう
" see https://code.google.com/p/macvim-kaoriya/wiki/Readme#文字コード判別

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

nnoremap <unique> <Leader>] :vertical stag <C-R>=expand('<cword>')<CR><CR>
nnoremap <unique> <Leader>g] :vertical stselect <C-R>=expand('<cword>')<CR><CR>


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

"" Macのクリップボードをペースト {{{
nnoremap <unique> <silent> <Leader>v "*p
vnoremap <unique> <silent> <Leader>v "*p
nnoremap <unique> <silent> <Leader>y "*y
vnoremap <unique> <silent> <Leader>y "*y
" }}}

" }}}

" Plugin Setting {{{

"" unite {{{
"let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:unite_source_file_rec_max_cache_files = 100000

call unite#custom_source('file_rec', 'ignore_pattern', (unite#sources#rec#define()[0]['ignore_pattern']) . '\|\%(^\|/\)\%(cpan\|local\|node_modules\|vendor\)\%($\|/\)\|\.\%(gif\|png\|jpg\|jpeg\)$')

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

nnoremap <SID>[unite] <Nop>
nmap <Space> <SID>[unite]

nnoremap <silent> <SID>[unite]; :<C-u>Unite buffer file file/new file_mru -buffer-name=files -start-insert<CR>
nnoremap <silent> <SID>[unite]f :<C-u>Unite file file/new file_mru -buffer-name=files -start-insert<CR>
nnoremap <silent> <SID>[unite]o :<C-u>UniteWithBufferDir file file/new file_mru -buffer-name=files -start-insert<CR>
nnoremap <silent> <SID>[unite]O :<C-u>UniteWithCurrentDir file file/new file_mru -buffer-name=files -start-insert<CR>
nnoremap <silent> <SID>[unite]r :<C-u>Unite file_rec:lib file_rec:t file_rec:templates file_rec:script file_rec:static file_rec:config -buffer-name=files -start-insert<CR>
nnoremap <silent> <SID>[unite]b :<C-u>Unite buffer -immediately -start-insert<CR>
nnoremap <silent> <SID>[unite]B :<C-u>Unite buffer -immediately -start-insert<CR>
nnoremap <silent> <SID>[unite]w :<C-u>Unite window:no-current<CR>
nnoremap <silent> <SID>[unite]p :<C-u>Unite register history/yank -buffer-name=register -no-split<CR>
nnoremap <silent> <SID>[unite]l :<C-u>Unite line -buffer-name=search -start-insert<CR>
nnoremap <silent> <SID>[unite][ :<C-u>Unite outline -vertical -hide-source-names -winwidth=40 -buffer-name=outline<CR>
nnoremap <silent> <SID>[unite]: :<C-u>Unite history/command -start-insert<CR>
nnoremap <silent> <SID>[unite]. :<C-u>Unite source<CR>
nnoremap <silent> <SID>[unite]t :<C-u>Unite tag<CR>
nnoremap <silent> <SID>[unite]q :<C-u>Unite qf -no-quit -no-empty -auto-resize -buffer-name=quickfix<CR>
nnoremap <silent> <SID>[unite]g :<C-u>Unite grep -buffer-name=search<CR>
nnoremap <silent> <SID>[unite]c :<C-u>Unite colorscheme -auto-preview<CR>
nnoremap <silent> <SID>[unite]h :<C-u>Unite help -auto-preview<CR>
"" }}}

"" vim-indent-guides {{{
let g:indent_guides_enable_on_vim_startup = 1
"}}}

"" airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'
"" }}}

"" neocomplepop {{{


let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_min_keyword_length = 3
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

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

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
let g:quickrun_config['watchdogs_checker/perl-projectlibs'] = {
      \   'command' : '~/.vim/tools/efm_perl.pl',
      \   'exec' : '%c %o %s:p',
      \   'quickfix/errorformat' : '%f:%l:%m',
      \ }
let g:quickrun_config['perl/watchdogs_checker'] = {
      \   'type' : 'watchdogs_checker/perl-projectlibs',
      \ }
let g:quickrun_config['scala/watchdogs_checker'] = {
      \   'type' : '',
      \ }

"" }}}

"" fugitive {{{

noremap <unique> <Leader>gs :<C-u>Gstatus<CR>
noremap <unique> <Leader>gd :<C-u>Gdiff<CR>
noremap <unique> <Leader>gb :<C-u>Gblame<CR>
noremap <unique> <Leader>ga :<C-u>Gwrite<CR>
noremap <unique> <Leader>gc :<C-u>Gcommit<CR>

"" }}}

"" tagbar {{{
noremap <unique> <Leader>]] :<C-u>TagbarToggle<CR>
"" }}}

"" undotree {{{

nnoremap <unique> <silent> <Leader>u :<C-u>UndotreeToggle<CR>

" }}}

"" tabular {{{

vnoremap <unique> <Leader>t :Tabularize /

" }}}

