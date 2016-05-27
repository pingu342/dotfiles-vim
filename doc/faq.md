# 関数名を表示したい

**tyru/current-func-info.vim**

	cfi#format("%s", "[No Func]")

上記のfunctionで関数名を取得可能

ステータスラインに関数名を表示させると画面スクロール時に重いときあり

また、カーソルが関数内にあるときに間違って"関数名無し"の結果を返す場合があり


**majutsushi/tagbar**

    tagbar#currenttag('%s', '[No Func]')

上記のfunctionで関数名を取得可能

ステータスラインに関数名を表示させると、画面スクロール時に重いときあり

カーソルが関数内にあるときに間違って"関数名無し"の結果を返すことはなかった

なぜかTlist表示中は"関数名無し"を返す


**taglist.vim**

    Tlist_Get_Tagname_By_Line()

上記のfunctionで関数名を取得可能

ステータスラインに関数名を表示させての画面スクロールが軽い

また`:Tlist`で関数一覧を表示可能

関数名を知りたいときに`:TlistHighlightTag`のコマンドを実行すれば関数一覧をハイライト可能


# lighline.vimを一時的に無効にしたい

NORMALモードで以下のコマンドを実行

	:call lightline#enable()
	:call lightline#disable()
	:call lightline#toggle()


# ESCで入力モードから抜ける時に自動でIMEをオフしたい

vim74-kaoriya-winの場合は、.vimrcに、

	inoremap <ESC> <ESC>:set iminsert=0<CR>

を追加する。

KaoriYa版のMacVimでは元からそうなっている。

[(参考)](https://github.com/splhack/macvim-kaoriya/wiki/Readme#%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%85%A5%E5%8A%9Bim%E8%87%AA%E5%8B%95%E3%82%AA%E3%83%B3%E3%82%AA%E3%83%95)


# MacVimでIMEオンで入力中に改行すると勝手にIMEオフされる

.vimrcの以下の行を削除する。しかしWinで自動補完に支障が出る（補完候補を選んでReturnキー時に改行される）。

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
	endfunction

[(参考)](http://baqamore.hatenablog.com/entry/2014/12/28/023713)


# Ubuntuのコマンドラインでvim使用時、配色がいまいち

.vimrcで`colorscheme mydark`を設定しているが期待の配色と異なる。

ターミナルの設定を変更する。

Edit -> Profiles... -> 'Default'をEdit -> Colorsタブ -> 'Built-in schemes'を'XTerm'に変更



