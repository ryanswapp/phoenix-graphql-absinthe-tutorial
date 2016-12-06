defmodule PhoenixGraphql.Web.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias PhoenixGraphql.{Repo, User}

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})
      {:error, _} ->
        conn
      _ ->
        conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
    {:ok, current_user} <- authorize(token) do
      {:ok, %{current_user: current_user}}
    end
  end

  defp authorize(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        "User:" <> id = Map.get(claims, "aud")

        User
        |> where(id: ^id)
        |> Repo.one
        |> case do
          nil -> {:error, "invalid authorization token"}
          user -> {:ok, user}
        end
      {:error, reason} -> {:error, reason}
    end
  end
end
