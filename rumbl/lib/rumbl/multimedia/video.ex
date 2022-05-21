defmodule Rumbl.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string

    belongs_to :user, Rumbl.Accounts.User
    belongs_to :category, Rumbl.Multimedia.Category

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:category)
  end
end

# {:ok, video} = Rumbl.Multimedia.create_video(%{
#   title: "New video", url: "http://example.com", description: "new video"
# })
# {:ok,
#  %Rumbl.Multimedia.Video{
#    __meta__: #Ecto.Schema.Metadata<:loaded, "v
# ideos">,
#    description: "new video",
#    id: 2,
#    inserted_at: ~N[2022-05-14 06:38:24],
#    title: "New video",
#    updated_at: ~N[2022-05-14 06:38:24],
#    url: "http://example.com",
#    user: #Ecto.Association.NotLoaded<associati
# on :user is not loaded>,
#    user_id: nil
#  }}

# video.user
##Ecto.Association.NotLoaded<association :user
#is not loaded>
# ecto associations are explicit

# video = Rumbl.Repo.preload(video, :user)
# %Rumbl.Multimedia.Video{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "vi
# deos">,
#   description: "new video",
#   id: 2,
#   inserted_at: ~N[2022-05-14 06:38:24],
#   title: "New video",
#   updated_at: ~N[2022-05-14 06:38:24],
#   url: "http://example.com",
#   user: nil,
#   user_id: nil
# }

# alias Ecto.Changeset
# alias Rumbl.Repo

# user = Rumbl.Accounts.get_user_by(username: "josevalim")
# %Rumbl.Accounts.User{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "us
# ers">,
#   id: 1,
#   inserted_at: ~N[2022-05-08 05:47:56],
#   name: "José",
#   password: nil,
#   password_hash: "$pbkdf2-sha512$160000$DDmLIT
# GXkGpGOVAKJQ1ShQ$kmBnMt5JYwVxcakn9zs4X1ePtpf.f
# b2ktU7k.QVYsFfYcTrRL1vfo0coxSeU8q6t2pXFHALF0If
# uNVYKRwR9Mg",
#   updated_at: ~N[2022-05-10 06:26:25],
#   username: "josevalim"
# }

# changeset = video |> Changeset.change() |> Changeset.put_assoc(:user, user)
##Ecto.Changeset<
#  action: nil,
#  changes: %{
#    user: #Ecto.Changeset<action: :update,
#     changes: %{}, errors: [],
#     data: #Rumbl.Accounts.User<>,
#     valid?: true>
#  },
#  errors: [],
#  data: #Rumbl.Multimedia.Video<>,
#  valid?: true
#>

# video = Repo.update!(changeset)
# %Rumbl.Multimedia.Video{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "vi
# deos">,
#   description: "new video",
#   id: 2,
#   inserted_at: ~N[2022-05-14 06:38:24],
#   title: "New video",
#   updated_at: ~N[2022-05-14 06:44:20],
#   url: "http://example.com",
#   user: %Rumbl.Accounts.User{
#     __meta__: #Ecto.Schema.Metadata<:loaded, "
# users">,
#     id: 1,
#     inserted_at: ~N[2022-05-08 05:47:56],
#     name: "José",
#     password: nil,
#     password_hash: "$pbkdf2-sha512$160000$DDmL
# ITGXkGpGOVAKJQ1ShQ$kmBnMt5JYwVxcakn9zs4X1ePtpf
# .fb2ktU7k.QVYsFfYcTrRL1vfo0coxSeU8q6t2pXFHALF0
# IfuNVYKRwR9Mg",
#     updated_at: ~N[2022-05-10 06:26:25],
#     username: "josevalim"
#   },
#   user_id: 1
# }

# video.user
# %Rumbl.Accounts.User{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "us
# ers">,
#   id: 1,
#   inserted_at: ~N[2022-05-08 05:47:56],
#   name: "José",
#   password: nil,
#   password_hash: "$pbkdf2-sha512$160000$DDmLIT
# GXkGpGOVAKJQ1ShQ$kmBnMt5JYwVxcakn9zs4X1ePtpf.f
# b2ktU7k.QVYsFfYcTrRL1vfo0coxSeU8q6t2pXFHALF0If
# uNVYKRwR9Mg",
#   updated_at: ~N[2022-05-10 06:26:25],
#   username: "josevalim"
# }

# video = video |> Changeset.change() |> Changeset.put_change(:user_id, user.id) |> Repo.update!()
# %Rumbl.Multimedia.Video{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "vi
# deos">,
#   description: "new video",
#   id: 2,
#   inserted_at: ~N[2022-05-14 06:38:24],
#   title: "New video",
#   updated_at: ~N[2022-05-14 06:44:20],
#   url: "http://example.com",
#   user: %Rumbl.Accounts.User{
#     __meta__: #Ecto.Schema.Metadata<:loaded, "
# users">,
#     id: 1,
#     inserted_at: ~N[2022-05-08 05:47:56],
#     name: "José",
#     password: nil,
#     password_hash: "$pbkdf2-sha512$160000$DDmL
# ITGXkGpGOVAKJQ1ShQ$kmBnMt5JYwVxcakn9zs4X1ePtpf
# .fb2ktU7k.QVYsFfYcTrRL1vfo0coxSeU8q6t2pXFHALF0
# IfuNVYKRwR9Mg",
#     updated_at: ~N[2022-05-10 06:26:25],
#     username: "josevalim"
#   },
#   user_id: 1
# }

# video = Repo.get(Rumbl.Multimedia.Video, video.id)
# %Rumbl.Multimedia.Video{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "vi
# deos">,
#   description: "new video",
#   id: 2,
#   inserted_at: ~N[2022-05-14 06:38:24],
#   title: "New video",
#   updated_at: ~N[2022-05-14 06:44:20],
#   url: "http://example.com",
#   user: #Ecto.Association.NotLoaded<associatio
# n :user is not loaded>,
#   user_id: 1
# }

# video = Repo.preload(video, :user)
# %Rumbl.Multimedia.Video{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "vi
# deos">,
#   description: "new video",
#   id: 2,
#   inserted_at: ~N[2022-05-14 06:38:24],
#   title: "New video",
#   updated_at: ~N[2022-05-14 06:44:20],
#   url: "http://example.com",
#   user: %Rumbl.Accounts.User{
#     __meta__: #Ecto.Schema.Metadata<:loaded, "
# users">,
#     id: 1,
#     inserted_at: ~N[2022-05-08 05:47:56],
#     name: "José",
#     password: nil,
#     password_hash: "$pbkdf2-sha512$160000$DDmL
# ITGXkGpGOVAKJQ1ShQ$kmBnMt5JYwVxcakn9zs4X1ePtpf
# .fb2ktU7k.QVYsFfYcTrRL1vfo0coxSeU8q6t2pXFHALF0
# IfuNVYKRwR9Mg",
#     updated_at: ~N[2022-05-10 06:26:25],
#     username: "josevalim"
#   },
#   user_id: 1
# }

# query = Ecto.assoc(video, :user)
##Ecto.Query<from u0 in Rumbl.Accounts.User,
# where: u0.id == ^1>

# Repo.one(query)
# %Rumbl.Accounts.User{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "us
# ers">,
#   id: 1,
#   inserted_at: ~N[2022-05-08 05:47:56],
#   name: "José",
#   password: nil,
#   password_hash: "$pbkdf2-sha512$160000$DDmLIT
# GXkGpGOVAKJQ1ShQ$kmBnMt5JYwVxcakn9zs4X1ePtpf.f
# b2ktU7k.QVYsFfYcTrRL1vfo0coxSeU8q6t2pXFHALF0If
# uNVYKRwR9Mg",
#   updated_at: ~N[2022-05-10 06:26:25],
#   username: "josevalim"
# }
