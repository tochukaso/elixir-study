# Elixirについて

## Elixirとは

[Wikipediaによると]、以下の通りです。

Elixir (エリクサー) は並行処理の機能や関数型といった特徴を持つ、Erlangの仮想マシン (BEAM) 上で動作するコンピュータプログラミング言語である。

ElixirはErlangで実装されているため、分散システム、耐障害性、ソフトリアルタイムシステム等の機能を使用することができるが、拡張機能として、マクロを使ったメタプログラミング、そしてポリモーフィズムなどのプログラミング・パラダイムもプロトコルを介して実装されている。

Ruby on RailsのコアメンバーであるJosé Valimにより、2012年にリリースされた。
Rubyの構文や思想に影響を受けて作成されている。

## Elixirのメリット

- WebSocketが標準的なフレームワーク([Phoenix])で対応している。
- サーバーのスペックがそのままパフォーマンスに反映される
- 関数型言語なので、オブジェクトの状態について意識しなくてよい。
  - デバッグ、プログラムを追いかけるのが容易になる。
- WebSocketが標準的なフレームワークで対応している。
- 簡潔に構文を書くことが出来る。
  - パターンマッチングやガード節といった強力な構文がある。
  - 特にメソッドチェーンが気持ちいい。以下はペイロードからSignatureを取得する例

``` elixir
signature =
  payload
  |> :public_key.sign(:sha, decode_pk(private_key))
  |> Base.encode64()
  |> String.to_charlist()
  |> Enum.map(&replace/1)
  |> to_string()
```

## Elixirのデメリット

- 動的型付け言語のため、複数人の開発で使いづらいところはある
  - 特にメソッドの引数を[Map]型にすることが多く、引数に求められている値をメソッドの中身を確認して知ることが多い。
- 黒魔術的な難しい構文(マクロ)がある
- Elixirのマニュアルだけではなく、ErlangのAPIマニュアルの確認や、Erlangの仕様についても調査が必要となることがある。

## Elixirのハンズオン

## インストール方法

[Elixirのインストール]について記載します。

### [macOSの場合](https://elixir-lang.org/install.html#macos)

macの場合、以下の二通りの方法でインストールできます。

各ソフトウェアのバージョン管理などをかっちりとやりたいなら[asdf]がおすすめ。

とりあえずさくっと[Elixir]をインストールする場合、Homebrewでいいかなと思います。

- Homebrewを使ってインストールする
  - Homebrewをアップデートしてインストールする

``` shell
$ brew update
$ brew install elixir
```

- [asdf]を使ってインストールする
  - 事前にasdfをインストールする
  - Elixirとerlangのプラグインを追加する

``` shell
asdf plugin-add elixir \
    ; asdf plugin-add erlang \
```

  - asdfで使用できるバージョンを調べる
    - `asdf list all elixir`
  - asdfでelixirとerlangをインストールする
  
``` shell
asdf install erlang 23.1.1
asdf install elixir 1.11.1
```

### [Windowsの場合]

Windowsでのインストールは試していないのですが、 公式サイトによると、[インストーラーをダウンロード]して、
`Click next, next, …, finish`でインストールできます。


## Elixirの起動

ターミナルから`iex`コマンドで対話型のシェルとして起動できます。

``` elixir
$ iex                                                                                                        [15:55:39]
Erlang/OTP 22 [erts-10.6] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Interactive Elixir (1.10.3) - press Ctrl+C to exit (type h() ENTER for help)
```

### Hello world

コンソールに`Hello world`を出力してみましょう。

``` elixir
iex(1)> IO.puts("Hello world")
Hello world
:ok
```

次はコンソールに足し算の結果を出力してみましょう。

``` elixir
iex(2)> IO.puts(1 + 2)
3
:ok
```

これでElixirのプログラムの実行方法については分かりました。

次はプロジェクトの作成に取り掛かりたいと思います。

## Hexのインストール

[Hex]とはErlangのエコシステムのためのパッケージマネージャーです。

Elixirからも利用することが出来ます。

`$ mix local.hex`を使用することで、Hexのインストール・アップデートを行えます。

_mix.exs_ ファイルというプロジェクトを管理するためのファイルに依存するパッケージを記載することが出来ます。

{:パッケージ名, パッケージの要件, (オプション)}の形式で記載します。

パッケージの要件の箇所には必要なバージョンや、githubのリポジトリーを指定することが出来ます。

オプションの箇所にはテスト時のみに必要(`only: :test`)などの条件が記載できます。

``` elixir
  defp deps() do
    [
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.8.1"},
      {:cowboy, github: "ninenines/cowboy"},
    ]
  end
```

パッケージを追加した場合、`mix deps.get`コマンドを実行することで、必要なライブラリーをインストールすることが出来ます。

_Node.js_ で _package.json_ にパッケージを追加した後に`npm install`するのと同じ様なイメージです。

## Phoenixとは

[Phoenix]とは、MVCパターンを実装したWebアプリケーション開発用のフレームワークです。

WebSocketやWebSocketを利用して画面の表示をSPAの様に切り替えるLiveViewという機能があります。

チュートリアルモジュールも内包されており、スピーディーに開発を始めるための環境も用意されています。

## Phoenix Projectの作成

[Phoenixのインストール]を行います。

`$ mix archive.install hex phx_new 1.5.6`

[Phoenix Projectの作成]を行っていきます。

以下のコマンドをターミナルから実行してください。

``` shell
$ mix phx.new hello --no-ecto
```

`--no-ecto`のオプションを設定することで、DB周りのライブラリや設定を作成せずにプロジェクトが作成できます。

事前にDBを用意するのに手間がかかるので、今回はDB周りを考慮せずにプロジェクトを作成することにします。

依存ライブラリー(dependencies)のインストールは _y_ を押してください。

`ls`などのコマンドで確認すると _hello_ ディレクトリが作成されています。

`cd hello` でhelloディレクトリに移動してください。

`mix phx.server`というコマンドを実行すると、Phoenixのサンプルアプリケーションが起動します。

_http://localhost:4000_ でアクセス出来ます。

## PhoenixでCRUDを実装する

DBはインストールしていないので、Elixirで利用できるオンメモリーのデータ格納機構である[ETS]を利用します。

ちなみに業務で利用したことはないですが、[FastGlobal]というより高速なデータ格納機構もあります。

こちらは[Discordが500万のユーザーの同時接続]の際に使用したものになります。

映画のレビューを保存して検索する機能を作成したいと思います。

### Rootingの追加

WebApplicationのリクエストを受け付けるための設定を追加します。

_hello/lib/hello_web/router.ex_ に`get "/movie", MovieController, :index`を追記します。

追加後は以下の様になります。

``` elixir
  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/movie", MovieController, :index
    get "/movie/new", MovieController, :new
    post "/movie", MovieController, :create
    get "/movie/:title", MovieController, :show
    put "/movie", MovieController, :update
    delete "/movie/:title", MovieController, :delete
  end
```

### Controllerの追加

Routingの設定に従って、Controllerのパブリックな関数が呼び出されます。

一覧を表示するための関数は以下のようになります。

``` elixir

  def index(conn, _params) do
    Logger.info("called index")
    render_index(conn)
  end

  defp render_index(conn) do
    movies =
      MovieEts.read_all()
      |> Enum.map(fn {_, movie} ->
        movie
      end)

    render(conn, "index.html", movies: movies)
  end

```

Routingで`get "/movie", MovieController, :index`の様に設定しています。

これは、_/movie_ のパスに _GET_ メソッドでリクエストが来た場合、 _MovieController_ の _index_ 関数を割り当てるようにルーティングで指定しています。

同様に、`delete "/movie/:title", MovieController, :delete`の場合、
_/movie_/:title のパスに _DELETE_ メソッドでリクエストが来た場合、 _MovieController_ の _delete_ 関数を割り当てるようにルーティングで指定しています。

:titleで指定した部分は関数の引数にマップのキーとして設定されます。

以下の様にパターンマッチングを使用すると、titleという変数にパラメーターを割り当てることも出来ます。

``` elixir
def delete(conn, %{"title" => title}) do
```

### ETSの追加

ETSはErlangに組み込まれているオンメモリーのデータベースなので、特別何かを設定しなくてもすぐに利用できます。

[ETSでテーブルを作成]する場合、以下の様に記載します。

``` elixir
:ets.new(:table_name, [:public, :named_table])
```

`:table_name`の部分に任意のテーブル名を設定できます。

`:public`の部分はこのテーブルにアクセスできるプロセスを指定できます。:publicの場合、どのプロセスからでもアクセスできます。

他には`:protected`(所有者のプロセス以外の場合、データの読み取りは出来るが書き込みは出来ない),`:private`(所有者のプロセス以外アクセスできない)

_application.ex_ の`start`関数にETSのテーブルを作成する処理を追加します。


### viewの追加

_Controller_ が`render`を使用して描画用のHTMLを作成する際に、 _view_ が必要になります。

``` elixir
defmodule HelloWeb.MovieView do
  use HelloWeb, :view
end
```

_view_ に関数を追加することで、テンプレートから呼び出すこともできます。

### 画面表示用のテンプレートの追加


[asdf]: https://asdf-vm.com/#/
[Discordが500万のユーザーの同時接続]: https://blog.discord.com/scaling-elixir-f9b8e1e7c29b
[Elixir]: https://elixir-lang.org/
[Elixirのインストール]: https://elixir-lang.org/install.html
[ETS]: https://hexdocs.pm/ets/ETS.html
[ETSでテーブルを作成]: https://erlang.org/doc/man/ets.html#new-2
[FastGlobal]: https://github.com/discord/fastglobal
[Hex]: https://hex.pm/
[macOSの場合]: https://elixir-lang.org/install.html#macos
[Map]: https://hexdocs.pm/elixir/Map.html
[Phoenix]: https://www.phoenixframework.org/
[Phoenix Projectの作成]: https://hexdocs.pm/phoenix/up_and_running.html
[Phoenixのインストール]: https://hexdocs.pm/phoenix/installation.html
[Wikipediaによると]: https://ja.wikipedia.org/wiki/Elixir_(%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E8%A8%80%E8%AA%9E)
[Windowsの場合]: https://elixir-lang.org/install.html#windows
[インストーラーをダウンロード]: https://github.com/elixir-lang/elixir-windows-setup/releases/download/v2.1/elixir-websetup.exe

