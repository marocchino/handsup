# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :handsup,
  ecto_repos: [Handsup.Repo]

# Configures the endpoint
config :handsup, Handsup.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V/2qNvMgw+y8eBK0gzUyzi4ctoBRrwnDW080BOyLbhcVn2c+7lt8d+co1/MoAeDB",
  render_errors: [view: Handsup.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Handsup.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
