defmodule Fibonacci do
  ## 単純に再帰関数を使用して計算する場合
  def calc(0), do: 1
  def calc(1), do: 1
  def calc(n), do: calc(n - 2) + calc(n - 1)

  ## 既に計算済みの値を引数に取って昇順に計算する方法
  def ex_calc(0), do: 1
  def ex_calc(1), do: 1
  def ex_calc(n), do: ex_calc(1, 1, 2, n)
  defp ex_calc(two_ago, before, index, n) do
    now = two_ago + before

    if index == n do
      now
    else
      ex_calc(before, now, index + 1, n)
    end
  end

  ## キャッシュに格納して降順に再帰的に計算する方法
  def fib(n) do
    {n, _cache} = fib(n, %{})
    n
  end

  defp fib(0, cache), do: { 1, cache }
  defp fib(1, cache), do: { 1, cache }
  defp fib(n, cache) do
    if Map.has_key?(cache, n) do
      { Map.get(cache, n), cache }
    else
      { r1, r1_cache } = fib(n - 1, cache)
      { r2, r2_cache } = fib(n - 2, r1_cache)
      { r1 + r2, Map.put(r2_cache, n, r1 + r2) }
    end
  end

end
