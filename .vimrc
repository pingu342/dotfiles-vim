" Install dein.vim
let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

"vi非互換（デフォルトでnocompatibleのため不要らしい）
" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

"if has('vim_starting')
"  set runtimepath+=~/.vim/bundle/neobundle.vim/
"endif

" Set dein base path (required)
let s:dein_base = '~/.cache/dein/'

" Set dein source path (required)
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set dein runtime path (required)
execute 'set runtimepath+=' .. s:dein_src

" Call dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')


"call neobundle#begin(expand('~/.vim/bundle/'))

"NeoBundleFetch 'Shougo/neobundle.vim'

call dein#add( 'tpope/vim-fugitive' )
call dein#add( 'Lokaltog/vim-easymotion' )
call dein#add( 'rstacruz/sparkup', {'rtp': 'vim/'} )
call dein#add( 'tpope/vim-rails.git' )
" vim-scripts repos
call dein#add( 'vim-scripts/L9' )
call dein#add( 'vim-scripts/FuzzyFinder' )
" non github repos
call dein#add( 'wincent/command-t' )
" ...
call dein#add( 'thinca/vim-quickrun' )
call dein#add( 'ivechan/gtags.vim' )
call dein#add( 'vim-scripts/taglist.vim' )
" Markdown ->
call dein#add( 'plasticboy/vim-markdown' )
call dein#add( 'kannokanno/previm' )
call dein#add( 'tyru/open-browser.vim' )
" <- Markdown
call dein#add( 'Shougo/neocomplcache' )
call dein#add( 'Shougo/neocomplete' )
call dein#add( 'vim-scripts/grep.vim' )
call dein#add( 'tpope/vim-commentary' )
call dein#add( 'tyru/current-func-info.vim' )
call dein#add( 'itchyny/lightline.vim' )
call dein#add( 'majutsushi/tagbar' )
call dein#add( 'yonchu/accelerated-smooth-scroll' )

call dein#add( 'Shougo/unite.vim' )
call dein#add( 'Shougo/unite-outline' )

" Finish dein initialization (required)
call dein#end()

"call neobundle#end()

"vim74-kaoriya-winのgvimでエラーになるため
if !has('gui_running')
	colorscheme mydark
endif
highlight LineNr ctermfg=darkyellow

"ファイルタイプpluginとindentを有効
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

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

"ファイル名として許される文字から:を抜く (winでgfコマンドに必要)
if has('win32') || has ('win64')
	set isfname-=:
endif

"Quickfix移動
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

"Quickfixリスト(FuzzyFinder)
nmap <Space>q :FufQuickfix<CR>

"バッファリスト(FuzzyFinder)
"nmap <Space>b :buffers<CR>:b 
nmap <Space>b :FufBuffer<CR>

"タグリスト(FuzzyFinder)
nmap <Space>t :FufTag<CR>

"ファイルリスト(FuzzyFinder)
nmap <Space>f :FufFile **/<CR>

"現在の関数名を表示
"nnoremap <C-g>f :echo cfi#format("%s", "no function")<CR>
"Tlistを更新
nnoremap <C-g>f :TlistUpdate<CR> :TlistSync<CR>

"Esc連打でハイライト解除
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"次の検索候補をウィンド中央に表示
nmap n nzz
nmap N Nzz

"入力補完でpreview windowを表示させない
set completeopt=menuone

"-----------taglist------------------------"
let Tlist_Process_File_Always = 1
"let Tlist_Use_Right_Window = 1

"-----------Shougo/neocomplete-------------"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"------------------------------------------"

"vim74-kaoriya-win用のgrep
if has('win32') || has ('win64')
    if executable('jvgrep')
        set grepprg=jvgrep\ -8\ -n
    else
        set grepprg=C:\mytools\vim74-kaoriya-win\GitBin\grep\ --text\ -n
    endif
    "grep.vim用にGitbashのgpreにパスを通す (残念ながらjvgrepに置き換えられない)
    let Grep_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\grep.exe' 
    let Grep_Xargs_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\xargs.exe' 
    let Grep_Find_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\find.exe'
    let Egrep_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\grep.exe -E' 
    let Grep_Shell_Quote_Char = '"'
else
    if executable('jvgrep')
        set grepprg=jvgrep\ -8\ -n
    endif
endif

"grep.vim用の設定
let Grep_Skip_Files = '*.exe *.so *.a *.o *.bak *~ tags GPATH GRTAGS GTAGS'
let Grep_Skip_Dirs = '.svn .git'
let Grep_Default_Options = '--text'

"vim74-kaoriya-winでESCキーでIMEをOFF
if has('win32') || has ('win64')
    inoremap <ESC> <ESC>:set iminsert=0<CR>
endif
"unix系でESCキーでIMEをOFF
if has ('unix')
" 以下を設定すると入力モード中の方向キーがvi互換動作になってしまう
"    function! ImInActivate()
"        call system('fcitx-remote -c')
"    endfunction
"    inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>
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

"---------------vim-markdown--------------"
" folding(折り畳み)を無効
let g:vim_markdown_folding_disabled = 1
"------------------------------------------"

"背景を透過させる
"colorschemeセット後に設定すること
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

