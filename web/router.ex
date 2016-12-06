defmodule PhoenixGraphql.Router do
  use PhoenixGraphql.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :graphql do
    plug PhoenixGraphql.Web.Context
  end

  scope "/", PhoenixGraphql do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug,
      schema: PhoenixGraphql.Schema
  end

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: PhoenixGraphql.Schema

end
