defmodule PhoenixGraphql.UserResolver do
  alias PhoenixGraphql.Repo
  alias PhoenixGraphql.User

  def all(_args, _info) do
    {:ok, Repo.all(User)}
  end
end
