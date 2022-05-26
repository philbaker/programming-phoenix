# Rumbl.Repo.insert! %Rumbl.Multimedia.Category{name: "Test"}
# %Rumbl.Multimedia.Category{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "categori
# es">,
#   id: 1,
#   inserted_at: ~N[2022-05-19 05:02:56],
#   name: "Test",
#   updated_at: ~N[2022-05-19 05:02:56]
# }

# Rumbl.Repo.insert! %Rumbl.Multimedia.Category{name: "Test"}
# ** (Ecto.ConstraintError) constraint error when atte
# mpting to insert struct:
#     * categories_name_index (unique_constraint)

# Rumbl.Repo.insert! %Rumbl.Multimedia.Category{name: "hello"}, on_conflict: :nothing
# %Rumbl.Multimedia.Category{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "categori
# es">,
#   id: 3,
#   inserted_at: ~N[2022-05-19 05:07:51],
#   name: "hello",
#   updated_at: ~N[2022-05-19 05:07:51]
# }

# import Ecto.Query
# alias Rumbl.Repo
# alias Rumbl.Multimedia.Category

# query = from c in Category, select: c.name
# Repo.all query
# ["Test", "hello", "Action", "Drama", "Romance",
#  "Comedy", "Sci-fi"]

# Repo.all from c in Category,
#   order_by: c.name,
#   select: {c.name, c.id}
# [
#   {"Action", 8},
#   {"Comedy", 11},
#   {"Drama", 9},
#   {"hello", 3},
#   {"Romance", 10},
#   {"Sci-fi", 12},
#   {"Test", 1}
# ]

# query = Category
# query = from c in query, order_by: c.name
# query = from c in query, select: {c.name, c.id}
# Repo.all(query)
# [
#   {"Action", 8},
#   {"Comedy", 11},
#   {"Drama", 9},
#   {"hello", 3},
#   {"Romance", 10},
#   {"Sci-fi", 12},
#   {"Test", 1}
# ]

# import Ecto.Query
# alias Rumbl.Repo
# alias Rumbl.Accounts.User
# alias Rumbl.Multimedia.Video
# username = "josevalim"
# Repo.one(from u in User, where: u.username == ^username)
# %Rumbl.Accounts.User{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "users">
# ,
#   id: 1,
#   inserted_at: ~N[2022-05-08 05:47:56],
#   name: "José",
#   password: nil,
#   password_hash: "$pbkdf2-sha512$160000$DDmLITGXkGp
# GOVAKJQ1ShQ$kmBnMt5JYwVxcakn9zs4X1ePtpf.fb2ktU7k.QV
# YsFfYcTrRL1vfo0coxSeU8q6t2pXFHALF0IfuNVYKRwR9Mg",
#   updated_at: ~N[2022-05-10 06:26:25],
#   username: "josevalim"
# }

# username = 123
# Repo.all(from u in User, where: u.username == ^username)
# Error

# Repo.one from u in User,
#   select: count(u.id),
#   where: ilike(u.username, "j%") or
#     ilike(u.username, "c%")
# # 4

# users_count = from u in User, select: count(u.id)

# j_users = from u in users_count, where: ilike(u.username, ^"%j%")
# j_users = from q in users_count, where: ilike(q.username, ^"%j%")

# User
#   |> select([u], count(u.id))
#   |> where([u], ilike(u.username, ^"j%") or ilike(u.username, ^"c%"))
#   |> Repo.one()
# 4

# Ecto.Adapters.SQL.query(Repo, "SELECT power($1, $2)", [2, 10])
# [debug] QUERY OK db=0.6ms queue=0.9ms idle=1511.9ms
# SELECT power($1, $2) [2, 10]
# {:ok,
#  %Postgrex.Result{
#    columns: ["power"],
#    command: :select,
#    connection_id: 608586,
#    messages: [],
#    num_rows: 1,
#    rows: [[1024.0]]
#  }}

# video = Repo.one(from v in Video, limit: 1)
# video.user
# video = Repo.preload(video, :user)
# video.user.username
# "jeff"

# video = Repo.one(from v in Video, limit: 1,
#   preload: [:user])
# video.user.username
# "jeff"

# Repo.all from v in Video,
#   join: u in assoc(v, :user),
#   join: c in assoc(v, :category),
#   where: c.name == "Action",
#   select: {u, v}
# [
#   {%Rumbl.Accounts.User{
#      __meta__: #Ecto.Schema.Metadata<:loaded, "user
# s">,
#      id: 7,
#      inserted_at: ~N[2022-05-11 05:58:48],
#      name: "jeff",
#      password: nil,
#      password_hash: "$pbkdf2-sha512$160000$x9Dejbv5
# dCDLtaA30qttSg$LqA6FhS7/CdkbI/avAqZFojao1HMkhbOpu9M
# jN4UD/jOOO6g4/0j.EVCHbCI4Lf/C/UseVgCzCwuZL3uC9XwdQ"
# ,
#      updated_at: ~N[2022-05-11 05:58:48],
#      username: "jeff"
#    },
#    %Rumbl.Multimedia.Video{
#      __meta__: #Ecto.Schema.Metadata<:loaded, "vide
# os">,
#      category: #Ecto.Association.NotLoaded<associat
# ion :category is not loaded>,
#      category_id: 8,
#      description: "Insteresting",
#      id: 4,
#      inserted_at: ~N[2022-05-20 07:44:17],
#      title: "ElixirConf Keynote Action Movie",
#      updated_at: ~N[2022-05-20 07:44:17],
#      url: "https://www.youtube.com/watch?v=zbbK0WOv
# WII",
#      user: #Ecto.Association.NotLoaded<association
# :user is not loaded>,
#      user_id: 7
#    }}
# ]

# Ecto constraints
import Ecto.Query
alias Rumbl.Repo
alias Rumbl.Multimedia.{Video, Category}
category = Repo.get_by(Category, name: "Drama")
# %Rumbl.Multimedia.Category{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "categor
# ies">,
#   id: 9,
#   inserted_at: ~N[2022-05-19 05:20:33],
#   name: "Drama",
#   updated_at: ~N[2022-05-19 05:20:33]
# }
video = Repo.one(from v in Video, limit: 1)
# %Rumbl.Multimedia.Video{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "videos"
# >,
#   category: #Ecto.Association.NotLoaded<association
#  :category is not loaded>,
#   category_id: 8,
#   description: "Insteresting",
#   id: 4,
#   inserted_at: ~N[2022-05-20 07:44:17],
#   title: "ElixirConf Keynote Action Movie",
#   updated_at: ~N[2022-05-20 07:44:17],
#   url: "https://www.youtube.com/watch?v=zbbK0WOvWII
# ",
#   user: #Ecto.Association.NotLoaded<association :us
# er is not loaded>,
#   user_id: 7
# }

changeset = Video.changeset(video, %{category_id: category.id})
##Ecto.Changeset<
#  action: nil,
#  changes: %{category_id: 9},
#  errors: [],
#  data: #Rumbl.Multimedia.Video<>,
#  valid?: true
#>

Repo.update(changeset)
# {:ok,
#  %Rumbl.Multimedia.Video{
#    __meta__: #Ecto.Schema.Metadata<:loaded, "videos
# ">,
#    category: #Ecto.Association.NotLoaded<associatio
# n :category is not loaded>,
#    category_id: 9,
#    description: "Insteresting",
#    id: 4,
#    inserted_at: ~N[2022-05-20 07:44:17],
#    title: "ElixirConf Keynote Action Movie",
#    updated_at: ~N[2022-05-21 09:35:06],
#    url: "https://www.youtube.com/watch?v=zbbK0WOvWI
# I",
#    user: #Ecto.Association.NotLoaded<association :u
# ser is not loaded>,
#    user_id: 7
#  }}

changeset = Video.changeset(video, %{category_id: 12345})
##Ecto.Changeset<
#  action: nil,
#  changes: %{category_id: 12345},
#  errors: [],
#  data: #Rumbl.Multimedia.Video<>,
#  valid?: true
#>

Repo.update(changeset)
#{:error,
# #Ecto.Changeset<
#   action: :update,
#   changes: %{category_id: 12345},
#   errors: [
#     category: {"does not exist",
#      [
#        constraint: :assoc,
#        constraint_name: "videos_category_id_fkey"
#      ]}
#   ],
#   data: #Rumbl.Multimedia.Video<>,
#   valid?: false
# >}

# Constraints -  On delete
alias Rumbl.Repo
alias Rumbl.Multimedia.Category
category = Repo.get_by(Category, name: "Drama")
# %Rumbl.Multimedia.Category{
#   __meta__: #Ecto.Schema.Metadata<:loaded, "categor
# ies">,
#   id: ,
#   inserted_at: ~N[2022-05-19 05:20:33],
#   name: "Drama",
#   updated_at: ~N[2022-05-19 05:20:33]
# }

Repo.delete(category)
# constraint error

import Ecto.Changeset
changeset = change(category)
##Ecto.Changeset<action: nil, changes: %{},
# errors: [], data: #Rumbl.Multimedia.Category<>,
# valid?: true>
changeset = foreign_key_constraint(changeset, :videos, name: :videos_category_id_fkey, message: "still exist")
##Ecto.Changeset<action: nil, changes: %{},
# errors: [], data: #Rumbl.Multimedia.Category<>,
# valid?: true>

Repo.delete(changeset)
#{:error,
# #Ecto.Changeset<
#   action: :delete,
#   changes: %{},
#   errors: [
#     videos: {"still exist",
#      [
#        constraint: :foreign,
#        constraint_name: "videos_category_id_fkey"
#      ]}
#   ],
#   data: #Rumbl.Multimedia.Category<>,
#   valid?: false
# >}
