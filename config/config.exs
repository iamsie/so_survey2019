# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :so_survey,
  ecto_repos: [SoSurvey.Repo]

# Configures the endpoint
config :so_survey, SoSurveyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ee5ywO5OXMwnB9ZOyi4M8UTug4OCAFAKVSzs/4/lVYR+4UCmBrXwR/qO2ruIg3hs",
  render_errors: [view: SoSurveyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SoSurvey.PubSub,
  live_view: [signing_salt: "eGf2Qgrh"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
