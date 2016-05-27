# Windowsでもvimを使いたいの巻

本ファイルはWindows 7 (32bit or 64 bit) へvimをセットアップした記録である

> <参考> [Windowsにvimの環境を構築する方法](http://kaworu.jpn.org/vim/Windows%E3%81%ABvim%E3%81%AE%E7%92%B0%E5%A2%83%E3%82%92%E6%A7%8B%E7%AF%89%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95)

## Vim

### How to install

[KaoriYaさん](http://www.kaoriya.net/software/vim/)からダウンロードして`c:¥mytools¥vim74-kaoriya-win`に配置

## Git for Windows

外部grepなどのコマンドに利用

### How to install

[https://git-scm.com]() > Downloads > Windows からダウンロードしてインストール

インストールでは下記以外はデフォルト設定を選択

* チェックイン、チェックアウト時の改行コードの取り扱い
	* Checkout as-is, commit as-is
		* 改行コードを変換しない。

デフォルトでは勝手に改行コードを変換するモードが選ばれているので注意。

もしデフォルトのままインストールしてしまったら、後で以下を実行すること。

	git config --global core.autoCRLF false


### プロキシ設定方法

	git config --global http.proxy http://<proxy>:<port>

## Python

### How to install

[Python Japan](http://www.python.jp/) -> Python 2.7.11 ダウンロード -> Windows x86 MSI installer または x86-64 をダウンロード

インストールでは全てデフォルト設定を選択

## Mingw

vimprocを使うならMingwが必要

### How to install

[mingw-w64](http://mingw-w64.org/doku.php/start) -> Downloads -> Mingw-builds (version:Rolling host:Windows) からダウンロード

インストールが"Cannot download repository.txt"エラーで失敗

原因はHTTPプロキシ設定？

	netsh winhttp import proxy source=ie
	netsh winhttp set proxy proxy-server="<proxy>:<port>" bypass-list="*.local"
	netsh winhttp show proxy

をやってもインストール不可。
> <参考> [netshコマンド](http://www.maruko2.com/mw/WinHTTP%E3%83%97%E3%83%AD%E3%82%AD%E3%82%B7%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%96%B9%E6%B3%95)

代わりにパッケージ管理ツール(mingw-get-setup.exe)を[こちら](https://sourceforge.net/projects/mingw/?source=recommended)からダウンロードしてインストール 

> <参考> [MinGW(gcc) の Windows へのインストールと使い方](http://yohshiy.blog.fc2.com/blog-entry-292.html)

インストールされたパッケージ管理ツール`guimain`を実行し、mingw32-base、mingw32-gcc-g++を選択してApply Changesをクリック

PATHに`C¥MinGW¥bin`を追加

**★結局vimprocは使わないのでMingwは必要ないのでアンインストールした**

## .vimrc

### How to install

GitHubからdotfiles-vimをclone

	$ git clone https://github.com/pingu342/dotfiles-vim.git
	$ git submodule update --init

`mklink`で下記のリンクを作成

	c:¥Users¥ユーザー名¥.vimrc -> dotfiles-vim¥.vimrc
	c:¥Users¥ユーザー名¥.gvimrc -> dotfiles-vim¥.gvimrc
	c:¥Users¥ユーザー名¥.vim -> dotfiles-vim¥.vim

プラグインをインストール
vim起動後に、

	:NeoBundleInstall

### FAQ

#### Q. gvim起動時に"The protocol "git" is unsecure and invalid."エラーが出る

以下を修正

	NeoBundle 'git://git.wincent.com/command-t.git'
		↓
	NeoBundle 'https://git.wincent.com/command-t.git'

> <参考> [ブログ](http://littlewing.hatenablog.com/entry/2015/07/15/000000)

**★なぜかエラーが出なくなったので元に戻した**

#### Q. gvimのメニューが文字化けする

以下を.gvimrcに追加

	if has('win32') || has ('win64')
		source $VIMRUNTIME/delmenu.vim
		set langmenu=ja_jp.utf-8
		source $VIMRUNTIME/menu.vim
	endif

#### Q. gvim起動時に.vimrcの`colorscheme mydark`の行がエラーになる

.vimrcを修正

	if !has('gui_running')
		colorscheme mydark
	endif

## Taglist

### How to install

.vimrcに追加

	NeoBundle 'taglist.vim'

インストール

	:NeoBundleInstall

### FAQ

#### Q. gvim起動時に"Taglist: Exuberant ctags (http://ctags.sf.net) not found in PATH. Plugin is not loaded." エラーが出る

ctagがインストールされていないのが原因

Exuberant Ctagsの項を参照


## タブ化

### How to setup

.gvimrcに追加

	set showtabline=2

### FAQ

#### Q. 新規ウィンドウではなくタブで開きたい

レジストリ修正

	HKEY_CLASSES_ROOT¥c_auto_file¥shell¥open¥command = "C:¥mytools¥vim74-kaoriya-win¥gvim.exe" -p --remote-tab-silent "%1"

	HKEY_CLASSES_ROOT\Applications\gvim.exe\shell\open\command = "C:\mytools\vim74-kaoriya-win\gvim.exe" -p --remote-tab-silent "%1"

## フォント変更

MacVimで使っているOsakaフォントに変更する

### How to install

[Macの見やすいOsakaフォントをWinで使おうプロジェクト](http://ifs.nog.cc/osakattf.hp.infoseek.co.jp/)から**Osaka.zip**をダウンロードしてインストール

.gvimrcに追加

	set guifont=Osaka−等幅:h10:cSHIFTJIS
	set linespace=0
	set renderoptions=type:directx,renmode:5

> <参考> [レンダーオプション](https://hail2u.net/blog/software/vim-renderoptions-option.html)

結局、MS_Gothicフォントにレンダーオプションを付けたほうが綺麗だったので、Osakaフォントは使用せず

## 外部grep

### How to setup

デフォルトはfindstrコマンドを使う設定になっている

Git for windowsをインストールすればgrepコマンドが`C:¥Program Files¥Git¥usr¥bin`にインストールされているのでそれを使う

	$ cd C:¥mytools¥vim74-kaoriya-win
	$ mklink /d GitBin "C:¥Program Files¥Git¥usr¥bin"

.vimrcに追加

	if has('win32') || has ('win64')
		set grepprg=C:¥mytools¥vim74-kaoriya-win¥GitBin¥grep¥ -n
	endif


## grep.vim

### How to install

.vimrcに追加

	NeoBundle 'vim-scripts/grep.vim'

インストール

	:NeoBundleInstall

.vimrcに追加

	if has('win32') || has ('win64')
		let Grep_Path = 'C:¥mytools¥vim74-kaoriya-win¥GitBin¥grep.exe' 
		let Grep_Xargs_Path = 'C:¥mytools¥vim74-kaoriya-win¥GitBin¥xargs.exe' 
		let Grep_Find_Path = 'C:¥mytools¥vim74-kaoriya-win¥GitBin¥find.exe'
		let Egrep_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\grep.exe -E'
		let Grep_Shell_Quote_Char = '"'
	endif

> <参考> [Vimでファイル名検索やgrepをgrep.vimというプラグインで快適にした話](http://myenigma.hatenablog.com/entry/2016/01/17/184925)

### FAQ

#### Q. winでRgrepコマンドによる検索が正しく動作しない

指定したPathが間違っていないかを確認する

egrepのPathも指定すること


## Exuberant Ctags

### How to install

[http://ctags.sourceforge.net/]() からctags58.zipをダウンロード

gvim.exeと同じフォルダにctags.exeを置くか、PATHを通す

上記は日本語(特にShift-JIS)を正しく扱えないという問題があるらしい

[http://www.kaoriya.net/software/vim/]() からexuberant ctags 日本語対応版 5.8J2をダウンロード (32bit版しかない)

### Memo

* ctagsでは参照元へのジャンプはできない
やりたきゃ例えばGlobalを使う


## GNU Global

ctagsは*シンボルの定義*へジャンプ可能だが、*シンボルの参照元*(例えば、関数を呼び出している部分)へジャンプ不可、そこでGlobal

### How to install

[http://www.gnu.org/software/global/download.html]() > Binary archive > DOS and Windows 32 version

GLOBAL 6.5.3 Win32 (2.1M) のほうをダウンロードする (DOS版は実行不可だった)

gvim.exeと同じフォルダにglobal.exe, gtags.exeを置くか、PATHを通す

.vimrcに追加

	NeoBundle 'gtags.vim'

インストール

	:NeoBundleInstall

---
## TODO

* vimprocビルド
* オンラインアップデート環境

