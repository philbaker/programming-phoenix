defmodule Rumbl.Accounts.User do
  defstruct [:id, :name, :username]
end

# Map example - maps only check keys at runtime
# alias Rumbl.Accounts.User
# Rumbl.Accounts.User

# user = %{usernmae: "jose"}
# %{usernmae: "jose"}

# user.username
# ** (KeyError) key :username not found in: %{usernmae: "jose"}

# Struct example - structs check keys at compile time so offer better error
# protection
# jose = %User{name: "Jose Valim"}
# %Rumbl.Accounts.User{
#   id: nil,
#   name: "Jose Valim",
#   username: nil
# }

# chris = %User{nmae: "Chris"}
# ** (KeyError) key :nmae not found

# jose.__struct__
# Rumbl.Accounts.User
