defmodule Math do
  def inc(x), do: x + 1
  def dec(x), do: x - 1
end

2 |> Math.inc |> Math.inc |> Math.dec
# 3
