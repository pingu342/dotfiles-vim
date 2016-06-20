"vi非互換（デフォルトでnocompatibleのため不要らしい）
set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'tpope/vim-rails.git'
" vim-scripts repos
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
" non github repos
NeoBundle 'https://git.wincent.com/command-t.git'
" ...
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'gtags.vim'
NeoBundle 'taglist.vim'
NeoBundle 'Markdown'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'tpope/vim-commentary'
"NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'itchyny/lightline.vim'
"NeoBundle 'majutsushi/tagbar'
NeoBundle 'yonchu/accelerated-smooth-scroll'

call neobundle#end()

"vim74-kaoriya-winのgvimでエラーになるため
if !has('gui_running')
	colorscheme mydark
endif
highlight LineNr ctermfg=darkyellow

"ファイルタイプpluginとindentを有効
filetype plugin indent on

"エンコーディング
set enc=utf-8
set fencs=iso-2022-jp,sjis,enc-jp,utf-8

"ステータスライン内容 (※lightline.vim無効時)
" set statusline=%f\ %{'['.(&fenc!=''?&fenc:'?').'-'.&ff.']'} %q
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

"ステータスライン常時表示
set laststatus=2

"オートインデントを有効
set autoindent

"C言語スタイルのインデントを有効
set cindent
set backspace=2

"タブ,改行等の表示
set list
set listchars=tab:^\ ,eol:$,nbsp:%

"行番号を表示
set number

"--INSERT--モードを表示
set showmode

"右下に現在のカーソル位置を表示
set ruler

"対応するカッコを表示
set showmatch

"検索時のインクリメンタルサーチを有効
set incsearch

"検索にマッチした全てのテキストをハイライト
set hlsearch

"右下rulerの左側に入力途中コマンドを表示
set showcmd

"タブの文字数
"set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
"for python
autocmd FileType python setlocal expandtab
autocmd FileType python setlocal tabstop=8
autocmd FileType python setlocal softtabstop=4
autocmd FileType python setlocal shiftwidth=4
"for objective-c
autocmd FileType objc setlocal expandtab
autocmd FileType objc setlocal tabstop=4
autocmd FileType objc setlocal softtabstop=4
autocmd FileType objc setlocal shiftwidth=4
"fot text
autocmd FileType text setlocal textwidth=0

"カラー表示
syntax enable

"vi互換をオフ
set nocompatible

"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"Quicifix移動
"map <C-n> :cn<CR>
"map <C-p> :cp<CR>
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
nnoremap <silent> [Q :cfirst<CR>
nnoremap <silent> ]Q :clast<CR>

"バッファ移動
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"タグリスト移動
nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>

"バッファリスト
nmap <Space>b :buffers<CR>:b 

"現在の関数名を表示
"nnoremap <C-g>f :echo cfi#format("%s", "no function")<CR>
"Tlistを更新
nnoremap <C-g>f :TlistUpdate<CR>

"-----------Shougo/neocomplcache-----------"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"------------------------------------------"

"vim74-kaoriya-win用のgrep
if has('win32') || has ('win64')
    set grepprg=C:\mytools\vim74-kaoriya-win\GitBin\grep\ -n
    
    "grep.vim用にGitbashのgpreにパスを通す
    let Grep_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\grep.exe' 
    let Grep_Xargs_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\xargs.exe' 
    let Grep_Find_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\find.exe'
    let Egrep_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\grep.exe -E' 
    let Grep_Shell_Quote_Char = '"'
endif

"grep.vim用の設定
let Grep_Skip_Files = '*.bak *~'
let Grep_Skip_Dirs = '.svn .git'

"vim74-kaoriya-winでESCキーでIMEをOFF
if has('win32') || has ('win64')
    inoremap <ESC> <ESC>:set iminsert=0<CR>
endif

"対応するif/endifを%で移動
source $VIMRUNTIME/macros/matchit.vim

"------------- lightline.vim --------------"
if !has('gui_running')
    set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename' , 'funcname' ] ]
      \ },
      \ 'component': {
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename',
      \   'funcname': 'MyFuncname',
      \ }
      \ }

function! LightLineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '[readonly]' : ''
endfunction

function! LightLineAttribute()
    return LightLineReadonly() . LightLineModified()
endfunction

function! LightLineFilename()
    return ('' != LightLineAttribute() ? LightLineAttribute() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]')
endfunction

function! MyFuncname()
"current-func-info,tagbarどちらもスクロールが重い場合あり
"tagbarはTlist表示中に正しく動作しない
"    return cfi#format("%s", "[No Func]")
"    return tagbar#currenttag('%s', '[No Func]')
"taglistの関数名取得はスクロールが軽い
    return Tlist_Get_Tagname_By_Line()
endfunction

"--------accelerated-smooth-scroll---------"
"加速OFF
let g:ac_smooth_scroll_enable_accelerating = 0

"初速変更 (値が小さいほど速い)
let g:ac_smooth_scroll_du_sleep_time_msec = 0
let g:ac_smooth_scroll_fb_sleep_time_msec = 0
"------------------------------------------"

