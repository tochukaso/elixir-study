defmodule Hello do
  def hello(name \\ "") do
    IO.puts("Hello world #{name}")
  end
end
