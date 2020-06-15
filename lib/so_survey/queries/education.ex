defmodule SoSurvey.Queries.Education do
  alias SoSurvey.Repo
  import Ecto.Query, warn: false
  alias SoSurvey.SurveyResults

  # How many developers with the same rofessional coding experience contribute to open source?
  def contribute_to_open_source_by_years_code_pro_and_dev_type(years_code_pro) do
    SurveyResults
    |> from()
    |> where([s], s.years_code_pro == ^years_code_pro)
    |> where([s], not is_nil(s.open_sourcer))
    |> group_by([s], s.open_sourcer)
    |> select([s], %{"Contribution" => s.open_sourcer, "Number of developers" => count(s.id)})
    |> order_by([s], desc: count(s.id))
  end

  # What type of desgree do the developers of the same type have?
  def degree_type_by_dev_type(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], not is_nil(s.ed_level))
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        ed_level: s.ed_level,
        id: s.id
      })

    distinct_ids =
      query
      |> subquery()
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{ed_level: s.ed_level, id: s.id})
      |> distinct([s], s.id)

    distinct_ids
    |> subquery()
    |> group_by([s], s.ed_level)
    |> select([s], %{"Educational level" => s.ed_level, "Number of developers" => count(s.id)})
    |> order_by([s], desc: count(s.id))
  end

  # What Undergraduate Major do the developers of the same type have?
  def undergrad_major_by_dev_type(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], not is_nil(s.undergrad_major))
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        undergrad_major: s.undergrad_major,
        id: s.id
      })

    distinct_ids =
      query
      |> subquery()
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{undergrad_major: s.undergrad_major, id: s.id})
      |> distinct([s], s.id)

    distinct_ids
    |> subquery()
    |> group_by([s], s.undergrad_major)
    |> select([s], %{
      "Undergraduate major" => s.undergrad_major,
      "Number of developers" => count(s.id)
    })
    |> order_by([s], desc: count(s.id))
  end

  # What other types of education do the developers of the same type have?
  def ed_other_by_dev_type(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], s.edu_other != ["NA"])
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        edu_other: fragment("unnest(?)", s.edu_other),
        id: s.id
      })

    devs_by_the_same_dev_type =
      query
      |> subquery()
      |> where([s], not is_nil(s.edu_other))
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{edu_other: s.edu_other, id: s.id})

    devs_by_the_same_dev_type
    |> subquery()
    |> group_by([s], s.edu_other)
    |> select([s], %{"Non-formal education" => s.edu_other, "Number of developers" => count(s.id)})
    |> order_by([s], desc: count(s.id))
  end
end
