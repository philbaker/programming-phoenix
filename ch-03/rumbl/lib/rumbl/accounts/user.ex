defmodule Rumbl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end
end

# Map example - maps only check keys at runtime
# alias Rumbl.Accounts.User
# Rumbl.Accounts.User

# user = %{usernmae: "josé"}
# %{usernmae: "josé"}

# user.username
# ** (KeyError) key :username not found in: %{usernmae: "josé"}

# Struct example - structs check keys at compile time so offer better error
# protection
# jose = %User{name: "José Valim"}
# %Rumbl.Accounts.User{
#   id: nil,
#   name: "José Valim",
#   username: nil
# }

# chris = %User{nmae: "Chris"}
# ** (KeyError) key :nmae not found

# jose.__struct__
# Rumbl.Accounts.User

# Add users via ecto
# alias Rumbl.Repo
# alias Rumbl.Accounts.User
#
# Repo.insert(%User{
#   name: "José", username: "josevalim"
# })
#
# [debug] QUERY OK db=4.0ms decode=1.4ms queue=0.9ms
# idle=476.6ms
# INSERT INTO "users" ("name","username","inserted_at
# ","updated_at") VALUES ($1,$2,$3,$4) RETURNING "id"
#  ["José", "josevalim", ~N[2022-05-08 05:47:56], ~N
# [2022-05-08 05:47:56]]
# ↳ :erl_eval.do_apply/6, at: erl_eval.erl#685
# {:ok,
#  %Rumbl.Accounts.User{
#    __meta__: #Ecto.Schema.Metadata<:loaded, "users"
# >,
#    id: 1,
#    inserted_at: ~N[2022-05-08 05:47:56],
#    name: "José",
#    updated_at: ~N[2022-05-08 05:47:56],
#    username: "josevalim"
#  }}

# Repo.insert(%User{
#   name: "Bruce", username: "redrapids"
# })

# Repo.insert(%User{
#   name: "Chris", username: "chrismccord"
# })

# Repo.get(User, 1)
# %Rumbl.Accounts.User{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "users">
# ,
#   id: 1,
#   inserted_at: ~N[2022-05-08 05:47:56],
#   name: "José",
#   updated_at: ~N[2022-05-08 05:47:56],
#   username: "josevalim"
# }

