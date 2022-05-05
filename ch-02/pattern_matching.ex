{first, second, third} = {:lions, :tigers, :bears}
# {:lions, :tigers, :bears}

first
# :lions

{first, second, :bears} = {:lions, :tigers, :bears}
# {:lions, :tigers, :bears}

{first, second, :armadillos} = {:lions, :tigers, :bears}
# ** (MatchError) no match of right hand side value:
# {:lions, :tigers, :bears}

austin = %{city: "Austin", state: "Tx"}
# %{city: "Austin", state: "Tx"}

defmodule Place do
  def city(%{city: city}), do: city
  def texas?(%{state: "TX"}), do: true
  def texas?(_), do: false
end
