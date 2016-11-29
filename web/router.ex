defmodule PhoenixGraphql.Router do
  use PhoenixGraphql.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixGraphql do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  forward "/api", Absinthe.Plug,
    schema: PhoenixGraphql.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: PhoenixGraphql.Schema

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixGraphql do
  #   pipe_through :api
  # end
end
