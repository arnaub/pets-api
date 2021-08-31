# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pets_api,
  ecto_repos: [PetsApi.Repo]

# Configures the endpoint
config :pets_api, PetsApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fvn4oxf5OQ1jeHmNLBdCVKkifJJ6e5UXpFHBy09rOtHU5pw/0EzNVSXSKWd4dGu2",
  render_errors: [view: PetsApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PetsApi.PubSub,
  live_view: [signing_salt: "P9DRP4vu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
