defmodule Problem do
  def ans1(t) do
    t
    |> div(60)
    |> IO.puts
  end

  def ans2() do
    Enum.each(1..30, fn(x) ->
      cond do
        rem(x, 3 * 5) == 0 -> "FizzBuzz"
        rem(x, 3) == 0 -> "Fizz"
        rem(x, 5) == 0 -> "Buzz"
        true -> x
      end
      |> IO.puts()
    end)
  end

  def ans3(names) do
    Enum.uniq(names)
  end

end
