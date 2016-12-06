# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_graphql,
  ecto_repos: [PhoenixGraphql.Repo]

# Configures the endpoint
config :phoenix_graphql, PhoenixGraphql.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q/pRXuJQoZblGk4AIOHhMX0AkzuUpBS91hQVlO06PqrtRd/iAobc3CdBkMPDVYgc",
  render_errors: [view: PhoenixGraphql.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixGraphql.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "PhoenixGraphql",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "Q/pRXuJQoZblGk4AIOHhMX0AkzuUpBS91hQVlO06PqrtRd/iAobc3CdBkMPDVYgc",
  serializer: PhoenixGraphql.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
