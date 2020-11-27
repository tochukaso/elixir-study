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

end
