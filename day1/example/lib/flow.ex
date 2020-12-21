defmodule Flow do

  ## when キーワードの宣言について
  def hello(name, age) when age < 20 do
    IO.puts("Hello #{name} : #{age}")
    IO.puts("you are under twenty")
  end
  def hello(name, age) when age < 10 do
    IO.puts("Hello #{name} : #{age}")
    IO.puts("you are under ten")
  end
  def hello(name, 20) do
    IO.puts("Hello #{name}")
    IO.puts("you are twentee")
  end
  def hello(name, age) do
    IO.puts("Hello #{name} : #{age}")
    IO.puts("you are over nineteen")
  end

  ## パターンマッチングの確認
  def match(name, age) do
    pattern_match(name, is_under_twenty(age))
  end
  defp pattern_match(name, :ok) do
    IO.puts("Hello #{name}")
    IO.puts("you are under twenty")
  end
  defp pattern_match(name, :error) do
    IO.puts("Hello #{name}")
    IO.puts("you are over nineteen")
  end

  ## if,elseの使い方
  def is_under_twenty(age) do
    if age < 20 do
      IO.puts("age is under twenty")
      :ok
    else
      IO.puts("age is not less than twenty")
      :error
    end
  end

  ## for　ループ
  def hello_loop(count) do
    for x <- 1..count do
      IO.puts("hello #{x}")
    end
  end

  def enum_loop(count) do
    Enum.each(1..count, fn(x) ->
      IO.puts("hello #{x}")
    end)
  end

  ## collectionについての解説
  def collection() do
    # mapの宣言
    # キーにはatom、文字列の何れかが使えます。
    # atomをキーに使用する場合
    mike = %{name: "mike", age: 35}

    # 文字列をキーに使用する場合
    bob = %{"name" => "bob", "age" => 25}

    # mapの値を取得する。
    # キーワードがatomの場合、.<キー>, .<[atom]>の何れかの方法で値を取得できる。
    IO.puts("------------------mapへのアクセス------------------------")
    IO.puts(mike.name)
    IO.puts(mike[:name])
    # キーワードが文字列の場合、[文字列]で値を取得できる。
    IO.puts(bob["name"])
    IO.puts("------------------mapへのアクセス------------------------")

    # mapへの要素の追加
    mike_with_jobs = Map.put(mike, :job, "engineer")

    IO.puts("------------------mapの全要素の出力------------------------")
    # mapの全要素を出力する。
    mike_with_jobs
    |> Enum.to_list()
    |> Enum.each(fn({key, val}) ->
      IO.puts("#{key}: #{val}")
    end)
    IO.puts("------------------mapの全要素の出力------------------------")

    # listの宣言
    users_list = [mike, bob]

    # listの値の取得
    # IO.inspectは、開発時のデバック方法として、変数に格納されている値を確認するために利用します。
    IO.puts("------------------Listの先頭要素の確認------------------------")
    IO.inspect(Enum.fetch!(users_list, 0))
    IO.puts("------------------Listの先頭要素の確認------------------------")

    # listへの要素の追加
    added_users_list = users_list ++ [%{name: "sala", age: 19}]
    IO.puts("------------------要素を追加したListの確認------------------------")
    IO.inspect(added_users_list)
    IO.puts("------------------要素を追加したListの確認------------------------")

    # タプルの宣言
    # 変数の先頭に_をつけると、その変数が利用されない事を保証します。コンパイル時の警告を表示しない様に出来ます。
    _users_tuple = {mike, bob}

    # タプルは値を追加することが出来ず、関数の戻り値として利用されることが多いです。
    # {:ok, result}の様な形式で処理ステータスと結果が格納されます。

    # キーワードlistの宣言
    keyword_list = [first: mike, second: bob]

    # キーワードlistはmap
    # {:ok, result}の様な形式で処理ステータスと結果が格納されます。
    IO.puts("------------------要素を追加したListの確認------------------------")
    IO.inspect(added_users_list)
    IO.puts("------------------要素を追加したListの確認------------------------")

  end
end
