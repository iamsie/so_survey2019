use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :so_survey, SoSurvey.Repo,
  username: "postgres",
  password: "postgres",
  database: "test_db#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :so_survey, SoSurveyWeb.Endpoint,
  http: [port: 4004],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
