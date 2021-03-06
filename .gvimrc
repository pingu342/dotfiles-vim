"theme
colorscheme koehler

"半透明
if has('win32') || has ('win64') || has ('gui_macvim')
	autocmd GUIEnter * set transparency=20
endif

"vim74-kaoriya-winを半透明
if has('win32') || has ('win64')
	autocmd GUIEnter * set transparency=238
endif

"ツールバー非表示
set guioptions-=T

"vim74-kaoriya-winのメニュー文字化け対策
if has('win32') || has ('win64')
	source $VIMRUNTIME/delmenu.vim
	set langmenu=ja_jp.utf-8
	source $VIMRUNTIME/menu.vim
endif

"vim74-kaoriya-winのタブ表示
if has('win32') || has ('win64')
	set showtabline=2
endif

"vim74-kaoriya-winのフォント設定
if has('win32') || has ('win64')
"	set guifont=Osaka－等幅:h10:cSHIFTJIS
	set guifont=MS_Gothic:h10
	set linespace=0
	set renderoptions=type:directx,renmode:5
endif

"ウィンドウサイズを設定
if has('win32') || has ('win64')
	set lines=80
	set columns=120
endif

"macvimの設定
if has('gui_macvim')
	set guifontwide=Migu_1M:h12
	set guifont=Migu_1M:h13
endif

