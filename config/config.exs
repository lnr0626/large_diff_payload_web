# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :large_diff_payload,
  ecto_repos: [LargeDiffPayload.Repo]

# Configures the endpoint
config :large_diff_payload, LargeDiffPayloadWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y39cx5aM6WaofMKQxvFLzmOK7PCqfJQmfyHerDwOwWmbslMve8g3kilgzU46iCio",
  render_errors: [view: LargeDiffPayloadWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LargeDiffPayload.PubSub,
  live_view: [signing_salt: "xCIwArA2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
