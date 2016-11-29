defmodule PhoenixGraphql.Schema do
  use Absinthe.Schema
  import_types PhoenixGraphql.Schema.Types

  query do
    field :posts, list_of(:post) do
      resolve &PhoenixGraphql.PostResolver.all/2
    end

    field :users, list_of(:user) do
      resolve &PhoenixGraphql.UserResolver.all/2
    end
  end
end
