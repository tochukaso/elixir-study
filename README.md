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

```
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
```
$ brew update
$ brew install elixir
```
- [asdf]を使ってインストールする
  - 事前にasdfをインストールする
  - Elixirとerlangのプラグインを追加する
```
asdf plugin-add elixir \
    ; asdf plugin-add erlang \
```
  - asdfで使用できるバージョンを調べる
    - `asdf list all elixir`
  - asdfでelixirとerlangをインストールする
  
```
asdf install erlang 23.1.1
asdf install elixir 1.11.1
```

### [Windowsの場合]

Windowsでのインストールは試していないのですが、 公式サイトによると、[インストーラーをダウンロード]して、
`Click next, next, …, finish`でインストールできます。


## Elixirの起動

ターミナルから`iex`コマンドで対話型のシェルとして起動できます。
```
$ iex                                                                                                        [15:55:39]
Erlang/OTP 22 [erts-10.6] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Interactive Elixir (1.10.3) - press Ctrl+C to exit (type h() ENTER for help)
```

### Hello world

コンソールに`Hello world`を出力してみましょう。
```
iex(1)> IO.puts("Hello world")
Hello world
:ok
```
次はコンソールに足し算の結果を出力してみましょう。
```
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

```
  defp deps() do
    [
      {:ecto, "~> 2.0"},
      {:postgrex, "~> 0.8.1"},
      {:cowboy, github: "ninenines/cowboy"},
    ]
  end
```

## Phoenixとは

[Phoenix]とは、MVCパターンを実装したWebアプリケーション開発用のフレームワークです。

WebSocketやWebSocketを利用して画面の表示をSPAの様に切り替えるLiveViewという機能があります。

チュートリアルモジュールも内包されており、スピーディーに開発を始めるための環境も用意されています。

## Phoenix Projectの作成

[Phoenixのインストール]を行います。

`$ mix archive.install hex phx_new 1.5.6`

[Phoenix Projectの作成]を行っていきます。

以下のコマンドをターミナルから実行してください。

```
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




[asdf]: https://asdf-vm.com/#/
[Elixir]: https://elixir-lang.org/
[Wikipediaによると]: https://ja.wikipedia.org/wiki/Elixir_(%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E8%A8%80%E8%AA%9E)
[Elixirのインストール]: https://elixir-lang.org/install.html
[Hex]: https://hex.pm/
[macOSの場合]: https://elixir-lang.org/install.html#macos
[Map]: https://hexdocs.pm/elixir/Map.html
[Windowsの場合]: https://elixir-lang.org/install.html#windows
[Phoenix]: https://www.phoenixframework.org/
[Phoenix Projectの作成]: https://hexdocs.pm/phoenix/up_and_running.html
[Phoenixのインストール]: https://hexdocs.pm/phoenix/installation.html
[インストーラーをダウンロード]: https://github.com/elixir-lang/elixir-windows-setup/releases/download/v2.1/elixir-websetup.exe

