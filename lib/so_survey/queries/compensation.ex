defmodule SoSurvey.Queries.Compensation do
  alias SoSurvey.Repo
  import Ecto.Query, warn: false
  alias SoSurvey.SurveyResults

  # How much do the developers of the same type and years of professional coding earn?
  def comp_by_dev_type_and_years_code_pro(dev_type_list, years_code_pro) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], s.years_code_pro == ^years_code_pro)
      |> where([s], not is_nil(s.converted_comp))
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        converted_comp: s.converted_comp,
        id: s.id
      })

    distinct_ids =
      query
      |> subquery()
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{
        dev_type: s.dev_type,
        converted_comp: s.converted_comp
      })
      |> distinct([s], s.id)

    distinct_ids
    |> subquery()
    |> group_by([s], s.dev_type)
    |> select([s], %{dev_type: s.dev_type, compensation: avg(s.converted_comp)})
    |> order_by([s], desc: avg(s.converted_comp))
  end

  # What is the average salary of remote and office coders?
  def comp_by_work_type(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], not is_nil(s.employment))
      |> where([s], not is_nil(s.converted_comp))
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        employment: s.employment,
        converted_comp: s.converted_comp,
        id: s.id
      })

    distinct_ids =
      query
      |> subquery()
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{
        employment: s.employment,
        converted_comp: s.converted_comp
      })
      |> distinct([s], s.id)

    distinct_ids
    |> subquery()
    |> group_by([s], s.employment)
    |> select([s], %{
      employment: s.employment,
      compensation: avg(s.converted_comp)
    })
    |> order_by([s], desc: avg(s.converted_comp))
  end

  # How much the developers of the same type earn by gender?
  def comp_by_dev_type_and_gender(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], not is_nil(s.gender))
      |> where([s], not is_nil(s.converted_comp))
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        gender: s.gender,
        converted_comp: s.converted_comp,
        id: s.id
      })

    distinct_ids =
      query
      |> subquery()
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{
        gender: s.gender,
        converted_comp: s.converted_comp
      })
      |> distinct([s], s.id)

    distinct_ids
    |> subquery()
    |> group_by([s], s.gender)
    |> select([s], %{
      gender: s.gender,
      compensation: avg(s.converted_comp)
    })
    |> order_by([s], desc: avg(s.converted_comp))
  end

  # How much the developers of the same degree level and years of coding earn by the developer types?
  def comp_by_ed_level_and_years_code_pro(ed_level, years_code_pro) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], s.ed_level == ^ed_level)
      |> where([s], s.years_code_pro == ^years_code_pro)
      |> where([s], not is_nil(s.converted_comp))
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        converted_comp: s.converted_comp
      })

    query
    |> subquery()
    |> group_by([s], s.dev_type)
    |> select([s], %{dev_type: s.dev_type, compensation: avg(s.converted_comp)})
    |> order_by([s], desc: avg(s.converted_comp))
    |> limit([s], 7)
  end

  # What is the most paid language in your country?
  def comp_level_by_country_and_lang_worked_with(country) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.country == ^country)
      |> where([s], s.language_worked_with != ["NA"])
      |> where([s], not is_nil(s.converted_comp))
      |> select([s], %{
        language_worked_with: fragment("unnest(?)", s.language_worked_with),
        converted_comp: s.converted_comp
      })

    query
    |> subquery()
    |> group_by([s], s.language_worked_with)
    |> select([s], %{
      language_worked_with: s.language_worked_with,
      compensation: avg(s.converted_comp)
    })
    |> limit([s], 7)
  end
end
