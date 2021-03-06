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

	cmdを管理者で実行
	$ cd c:\Users\ユーザー名
	$ mklink .vimrc dotfiles-vim\.vimrc
	$ mklink .gvimrc dotfiles-vim\.gvimrc
	$ mklink /D .vim dotfiles-vim\.vim

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

#### Q. `:Tlist`でタグリストを開くと"taglist fails to generate tags"エラーが出る。

windows版gvimでこのエラーが出たときは、開いているファイルのPATHに日本語が含まれていたことが原因だった。


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

Git付属のgrepは日本語の検索ができない(UTF8ならできるが、他の文字コードはできない)

日本語検索のため[jvgrep](https://github.com/mattn/jvgrep)を使う場合の手順

まず、[Go](https://golang.org/)とjvgrepをインストール

** windows **

インストールすると環境変数PATHに`C:\Go\bin`が追加される

コマンドプロンプトで以下を実行

	> d:
	> cd d:\work
	> mkdir go
	> set GOPATH=d:\work\go
	> set http_proxy=http://<proxy_host>:<proxy_port>/
	> set https_proxy=http://<proxy_host>:<proxy_port>/
	> go get github.com/mattn/jvgrep

`d:\work\go\bin\jvgrep.exe`が作成されていることを確認

	> set PATH=%PATH%;d:\work\go\bin
	> jvgrep hoge **/*.txt

** ubuntu **

	$ sudo apt-get install golang
	$ export GOROOT=/usr/lib/go
	$ cd ~/work/go
	$ export GOPATH=~/work/go
	$ go get github.com/mattn/jvgrep

`~/work/go/bin/jvgrep`が作成されていることを確認

	$ export PATH=$PATH:~/work/go/bin
	$ jvgrep hoge **/*.txt

次に、.vimでjvgrepを使えるように設定

	if has('win32') || has ('win64')
	    if executable('jvgrep')
	        set grepprg=jvgrep\ -n
	    else
	        set grepprg=C:\mytools\vim74-kaoriya-win\GitBin\grep\ -n
	    endif
	    "grep.vim用にGitbashのgpreにパスを通す (残念ながらjvgrepに置き換えられない)
	    let Grep_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\grep.exe' 
	    let Grep_Xargs_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\xargs.exe' 
	    let Grep_Find_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\find.exe'
	    let Egrep_Path = 'C:\mytools\vim74-kaoriya-win\GitBin\grep.exe -E' 
	    let Grep_Shell_Quote_Char = '"'
	endif

検索パターンに正規表現を使わない場合、

	:grep -F hoge **/*.c

正規表現を使う場合、

	:grep -G ho.e **/*.c

jvgrepをgrep.vimで使用する方法?


### FAQ

#### Q.日本語の検索がうまくいかない

[外部grepの短所](https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-grep)

> * 日本語や日本語pathの扱いに問題がある場合がある。
> * ファイルごとに文字エンコーディングが違う時、特定の文字エンコーディングしか検索できない。
> * utf-8のBOM付きの場合、最初の一文字が検索できない事がある。

jvgrepを使えば日本語の検索できる。

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

このctagsはデフォルトで日本語がsjisになっている。

	>ctags --help
	...

	--jcode=ascii|sjis|euc|utf8
		Specify Japanese kanji code [sjis].

vimで開くファイルがutf8の場合、Tlistが空っぽだったり、タグジャンプできなかったり、いろいろ悲しいことが起こる。

デフォルトをsjisからutf8に変えたい場合は、ホームディレクトリに`.ctags`という隠しファイル（windowsでは隠れないが・・・）を作り`--jcode=utf8`と記載する。
これでデフォルトがutf8になる。



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


## fugitive

vimでgitコマンドを利用可能にするplugin

### How to install

	NeoBundle 'tpope/vim-fugitive'

Gdiffのためにはdiffコマンドをインストールする必要あり

diffコマンドはGit for windowsに入っている

以下のファイルをC:\Program Files\Git\usr\binからコピー

* msys-2.0.dll
* msys-iconv-2.dll
* msys-intl-8.dll
* msys-gcc_s-1.dll (win32環境では必要だった)
* diff.exe

(参考)

[windows環境のvimでfugitive.vimをインストールするなら「diff」コマンドのインストールを忘れない](http://niwaringo.tumblr.com/post/41359979786/windows%E7%92%B0%E5%A2%83%E3%81%AEvim%E3%81%A7fugitivevim%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B%E3%81%AA%E3%82%89diff%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9)

[Windows環境のvimエディタでdiff機能を使うには](http://nanasi.jp/articles/howto/diff/vimdiff_in_windows.html)


## FuzzyFinder

### FAQ

#### Q. windows版gvimで`:FufFile`等のコマンドで小窓を表示し、`ESC`で小窓を消した時、previous windowに戻らない

[Vim 7.4.1944 +kaoriya (2016/06/20)](https://github.com/koron/vim-kaoriya/releases/tag/v7.4.1944-20160620)を使用する。以降のバージョンで現象が発生している。

---
## TODO

* vimprocビルド
* オンラインアップデート環境

