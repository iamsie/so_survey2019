defmodule SoSurvey.Queries.MainPageForm do
  alias SoSurvey.Repo
  import Ecto.Query, warn: false
  alias SoSurvey.SurveyResults

  def list_dev_types() do
    SurveyResults
    |> from()
    |> where([s], s.dev_type != ["NA"])
    |> distinct(true)
    |> select(
      [s],
      fragment("unnest(?)", s.dev_type)
    )
  end

  def list_employments_variants() do
    SurveyResults
    |> from()
    |> where([s], not is_nil(s.employment))
    |> distinct(true)
    |> select(
      [s],
      s.employment
    )
  end

  def list_countries() do
    SurveyResults
    |> from()
    |> where([s], not is_nil(s.country))
    |> distinct(true)
    |> select(
      [s],
      s.country
    )
  end

  def list_languages() do
    SurveyResults
    |> from()
    |> where([s], s.language_worked_with != ["NA"])
    |> distinct(true)
    |> select(
      [s],
      fragment("unnest(?)", s.language_worked_with)
    )
  end

  def list_genders() do
    SurveyResults
    |> from()
    |> where([s], not is_nil(s.gender))
    |> distinct(true)
    |> select(
      [s],
      s.gender
    )
  end

  def list_ed_levels() do
    SurveyResults
    |> from()
    |> where([s], not is_nil(s.ed_level))
    |> distinct(true)
    |> select([s], s.ed_level)
  end
end
