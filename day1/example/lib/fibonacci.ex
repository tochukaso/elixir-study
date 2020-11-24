defmodule Fibonacci do
  def calc(n) do
    cond do
      n < 1 -> 0
      n <= 2 -> 1
      true -> calc(n - 2) + calc(n - 1)
    end
  end

  def ex_calc(n) do
    cond do
      n < 1 -> 0
      n <= 2 -> 1
      true -> ex_calc(1, 1, 2, n)
    end
  end

  defp ex_calc(two_ago, before, index, n) do
    now = two_ago + before

    if index + 1 == n do
      now
    else
      ex_calc(before, now, index + 1, n)
    end
  end
end
