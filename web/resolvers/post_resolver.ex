defmodule PhoenixGraphql.PostResolver do
  alias PhoenixGraphql.Repo
  alias PhoenixGraphql.Post

  def all(_args, _info) do
    {:ok, Repo.all(Post)}
  end
end
