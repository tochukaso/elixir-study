# Elixirについて

## Elixirとは

[Wikipediaによると]、以下の通りです。

Elixir (エリクサー) は並行処理の機能や関数型といった特徴を持つ、Erlangの仮想マシン (BEAM) 上で動作するコンピュータプログラミング言語である。

ElixirはErlangで実装されているため、分散システム、耐障害性、ソフトリアルタイムシステム等の機能を使用することができるが、拡張機能として、マクロを使ったメタプログラミング、そしてポリモーフィズムなどのプログラミング・パラダイムもプロトコルを介して実装されている。

Ruby on RailsのコアメンバーであるJosé Valimにより、2012年にリリースされた。
Rubyの構文や思想に影響を受けて作成されている。

## Elixirのメリット

- WebSocketが標準的なフレームワーク([Phoenix])で対応している。
- 関数型言語なので、オブジェクトの状態について意識しなくてよい。
  - デバッグ、プログラムを追いかけるのが容易になる。
  - 関数型言語のため、並列処理に強い。
  - サーバーのスペックがそのままパフォーマンスに反映される
- 関数型言語の割に学習コストが低いと言われている。
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

ここで、`:ok`というのは,IO.putsのレスポンスになります。
なので、変数にレスポンスを格納することが出来ます。
``` elixir
iex(2)> result = IO.puts("Hello world")
Hello world
:ok

iex(3)> result
:ok

iex(4)> result == :ok
true

iex(5)> result == :no
false
```

上では、`result`にIO.putsの結果(`:ok`)を格納して、
そのまま出力、`:ok`,`:no`との比較を行いました。

`result`に`:ok`という値が格納されていることが確認できました。

ちなみに`:`で始まる文字列は[atom]という定数です。
atomは、Erlangのビルトインのものも含めたライブラリのモジュールを参照するのにも使われます。

次はコンソールに足し算の結果を出力してみます。

``` elixir
iex(6)> IO.puts(1 + 2)
3
:ok
```

次はモジュールを作成して、Elixirをファイルから実行する方法について解説します。

## モジュールファイルの作成

_Hello.ex_というファイル名で以下のファイルを作成します。

``` elixir
defmodule Hello do
  def hello(name \\ "") do
    IO.puts("Hello world #{name}")
  end
end
```

iex(1)> c("Hello.ex")
[Hello]
iex(2)> Hello.hello("hoge")
Hello world hoge
:ok

iexから`c("<ファイル名>")`で対象のファイルをコンパイルしてVMに展開します。
_モジュール名.関数名_ でモジュールに定義されている関数を呼び出すことが出来ます。

次はプロジェクトの作成に取り掛かりたいと思います。

## mixの使用

$ mix new example

上記のコマンドでプロジェクトのフォルダ構成と必要なボイラープレートが生成されます。

``` shell
$ cd example
$ iex -S mix
iex(1)> Example.hello()
:world
```

exmpleディレクトリーに移動して、iex -S mixでmixプロジェクトを対話型シェルで立ち上げます。
_Example.ex_ に定義してあるhello関数を呼び出します。

## フィボナッチ数列を解く

[フィボナッチ数列]とは、「2つ前の項と1つ前の項を足し合わせていくことでできる数列」のことです。数列は「1,1」から始まり、

1, 1, 2, 3, 5, 8, 13, 21…

と続いていきます。

![フィボナッチ数列](fibonacci.png)

[100番目までのフィボナッチ数列]

`fibonacci.ex`に解き方を定義する。
## 宿題
ビールの箱詰め機械を実装してみよう。

引数を受け取って、箱の大きさに合致する瓶を格納して箱詰めしてください。
大きい箱から優先して使用する必要があります。

ビールの箱詰め機械の条件
- 整数がパラメーターとして渡されない場合、以下のエラーを返却する
  - "Error: Passed argument mu st be an integer"
- 箱にはそれぞれ以下の瓶が入ります。
  - big = 24本
  - medium = 12本
  - small = 6本

また、箱に入らなかった瓶はremaining_bottlesとして表示してください。

参考情報として、以下の引数の場合に以下の出力となることを確認してください。
``` shell
iex(1)> c("beer_factory.ex")
[BeerFactory]
iex(2)> BeerFactory.prep_boxes("Hello, world!")
"Error: Passed argument must be an integer"
iex(3)> BeerFactory.prep_boxes(43)
%{big: 1, medium: 1, remaining_bottles: 1, small: 1}
iex(4)> BeerFactory.prep_boxes(0)
%{remaining_bottles: 0}
iex(5)> BeerFactory.prep_boxes(3.1415)
"Error: Passed argument must be an integer"
iex(6)> BeerFactory.prep_boxes(31415)
%{big: 1308, medium: 1, remaining_bottles: 5, small: 1}
iex(7)> BeerFactory.prep_boxes(7)
%{remaining_bottles: 1, small: 1}
```


[atom]: https://elixirschool.com/ja/lessons/basics/basics/#アトム
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
[100番目までのフィボナッチ数列]: http://www.suguru.jp/Fibonacci/Fib100.html
[インストーラーをダウンロード]: https://github.com/elixir-lang/elixir-windows-setup/releases/download/v2.1/elixir-websetup.exe
[フィボナッチ数列]: https://www.studyplus.jp/445
