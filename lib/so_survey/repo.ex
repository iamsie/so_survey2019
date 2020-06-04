defmodule SoSurvey.Repo do
  use Ecto.Repo,
    otp_app: :so_survey,
    adapter: Ecto.Adapters.Postgres
end
