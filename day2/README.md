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

## Phoenix Projectの作成

[Phoenixのインストール]を行います。

`$ mix archive.install hex phx_new 1.5.6`

[Phoenix Projectの作成]を行っていきます。

以下のコマンドをターミナルから実行してください。

``` shell
$ mix phx.new rest --no-ecto
```

`--no-ecto`のオプションを設定することで、DB周りのライブラリや設定を作成せずにプロジェクトが作成できます。

事前にDBを用意するのに手間がかかるので、今回はDB周りを考慮せずにプロジェクトを作成することにします。

依存ライブラリー(dependencies)のインストールは _y_ を押してください。

`ls`などのコマンドで確認すると _rest_ ディレクトリが作成されています。

`cd rest` でrestディレクトリに移動してください。

`mix phx.server`というコマンドを実行すると、Phoenixのサンプルアプリケーションが起動します。

_http://localhost:4000_ でアクセス出来ます。

## PhoenixでCRUDを実装する

DBはインストールしていないので、Elixirで利用できるオンメモリーのデータ格納機構である[ETS]を利用します。

ちなみに業務で利用したことはないですが、[FastGlobal]というより高速なデータ格納機構もあります。

こちらは[Discordが500万のユーザーの同時接続]の際に使用したものになります。

映画のレビューを保存して検索する機能を作成したいと思います。

### Rootingの追加

WebApplicationのリクエストを受け付けるための設定を追加します。

_rest/lib/rest_web/router.ex_ に`get "/movie", MovieController, :index`を追記します。

追加後は以下の様になります。

``` elixir
  scope "/", RestWeb do
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
defmodule RestWeb.MovieView do
  use RestWeb, :view
end
```

_view_ に関数を追加することで、テンプレートから呼び出すこともできます。

### 画面表示用のテンプレートの追加