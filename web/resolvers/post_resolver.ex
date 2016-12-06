defmodule PhoenixGraphql.PostResolver do
  import Ecto.Query, only: [where: 2]
  alias PhoenixGraphql.Repo
  alias PhoenixGraphql.Post

  def all(_args, %{context: %{current_user: %{id: id}}}) do
    posts =
      Post
      |> where(user_id: ^id)
      |> Repo.all

    {:ok, posts}
  end

  def all(_args, _info) do
    {:error, "Not Authorized"}
  end

  def create(args, _info) do
    %Post{}
    |> Post.changeset(args)
    |> Repo.insert
  end

  def update(%{id: id, post: post_params}, _info) do
    Repo.get!(Post, id)
    |> Post.changeset(post_params)
    |> Repo.update
  end

  def delete(%{id: id}, _info) do
    post = Repo.get!(Post, id)
    Repo.delete(post)
  end
end
