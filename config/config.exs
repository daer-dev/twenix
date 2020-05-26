# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app,
  ecto_repos: [App.Repo]

# Database configuration.
config :app, App.Repo,
username: System.get_env("POSTGRES_USER"),
password: System.get_env("POSTGRES_PASSWORD"),
hostname: System.get_env("POSTGRES_HOST"),
port: System.get_env("POSTGRES_PORT"),
pool_size: String.to_integer(System.get_env("POSTGRES_POOL")),
pool: Ecto.Adapters.SQL.Sandbox

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IGBxnrtv87GpSqt4sLnAvkkUajUg9M1eNds6AmmqXr4gBcKmxncGWhiwzDjGbkh1",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: App.PubSub,
  live_view: [signing_salt: "C/QjtFVW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
