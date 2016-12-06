defmodule PhoenixGraphql.Web.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    IO.inspect Guardian.Plug.current_resource(conn)
    case Guardian.Plug.current_resource(conn) do
      nil -> conn
      user ->
        put_private(conn, :absinthe, %{context: %{current_user: user}})
    end
  end
end
