defmodule Rumbl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
      _ ->
        changeset
    end
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

# Changesets
# alias Rumbl.Accounts.User

# alias RumblWeb.Router.Helpers, as: Routes

# changeset = User.registration_changeset(%User{}, %{
#   username: "max", name: "Max", password: "123"
# })
##Ecto.Changeset<
#  action: nil,
#  changes: %{
#    name: "Max",
#    password: "123",
#    username: "max"
#  },
#  errors: [
#    password: {"should be at least %{count} charact
#er(s)",
#     [
#       count: 6,
#       validation: :length,
#       kind: :min,
#       type: :string
#     ]}
#  ],
#  data: #Rumbl.Accounts.User<>,
#  valid?: false
#>

# changeset = User.registration_changeset(%User{}, %{
#   username: "max", name: "Max", password: "asecret"
# })
##Ecto.Changeset<
#  action: nil,
#  changes: %{
#    name: "Max",
#    password: "asecret",
#    password_hash: "$pbkdf2-sha512$160000$ADwgbHL8m
#cpITuKPDidIjw$BI.vgsxYF4n8ltxR5JVcuSyDiphlxY3cQXv/.
#0baDZ16sglW6yQwLEtww6mYJRmR5eUbyW0UsWMKpNIdjXm/aw",
#    username: "max"
#  },
#  errors: [],
#  data: #Rumbl.Accounts.User<>,
#  valid?: true
#>

# changeset.valid?
# true

# changeset.changes
# %{
#   name: "Max",
#   password: "asecret",
#   password_hash: "$pbkdf2-sha512$160000$ADwgbHL8mcp
# ITuKPDidIjw$BI.vgsxYF4n8ltxR5JVcuSyDiphlxY3cQXv/.0b
# aDZ16sglW6yQwLEtww6mYJRmR5eUbyW0UsWMKpNIdjXm/aw",
#   username: "max"
# }

# Ensure existing users have a password

# alias Rumbl.Repo

# for u <- Repo.all(User) do
#   Repo.update!(User.registration_changeset(u, %{password: "temppass"}))
# end
