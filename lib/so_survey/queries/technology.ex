defmodule SoSurvey.Queries.Technology do
  alias SoSurvey.Repo
  import Ecto.Query, warn: false
  alias SoSurvey.SurveyResults

  # What is the most popular database used by the developers of your types?
  def most_popular_db_by_dev_type(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], s.database_worked_with != ["NA"])
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        database_worked_with: fragment("unnest(?)", s.database_worked_with),
        id: s.id
      })

    devs_by_the_same_dev_type =
      query
      |> subquery()
      |> where([s], not is_nil(s.database_worked_with))
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{database_worked_with: s.database_worked_with, id: s.id})

    devs_by_the_same_dev_type
    |> subquery()
    |> group_by([s], s.database_worked_with)
    |> select([s], %{
      database_worked_with: s.database_worked_with,
      number_of_developers: count(s.id)
    })
    |> order_by([s], desc: count(s.id))
  end

  def most_popular_platform_by_dev_type(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], s.platform_worked_with != ["NA"])
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        platform_worked_with: fragment("unnest(?)", s.platform_worked_with),
        id: s.id
      })

    devs_by_the_same_dev_type =
      query
      |> subquery()
      |> where([s], not is_nil(s.platform_worked_with))
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{platform_worked_with: s.platform_worked_with, id: s.id})

    devs_by_the_same_dev_type
    |> subquery()
    |> group_by([s], s.platform_worked_with)
    |> select([s], %{
      platform_worked_with: s.platform_worked_with,
      number_of_developers: count(s.id)
    })
    |> order_by([s], desc: count(s.id))
  end

  def most_popular_web_frame_by_dev_type(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], s.web_frame_worked_with != ["NA"])
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        web_frame_worked_with: fragment("unnest(?)", s.web_frame_worked_with),
        id: s.id
      })

    devs_by_the_same_dev_type =
      query
      |> subquery()
      |> where([s], not is_nil(s.web_frame_worked_with))
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{web_frame_worked_with: s.web_frame_worked_with, id: s.id})

    devs_by_the_same_dev_type
    |> subquery()
    |> group_by([s], s.web_frame_worked_with)
    |> select([s], %{
      web_frame_worked_with: s.web_frame_worked_with,
      number_of_developers: count(s.id)
    })
    |> order_by([s], desc: count(s.id))
  end

  def other_popular_techs_by_dev_type(dev_type_list) do
    query =
      SurveyResults
      |> from()
      |> where([s], s.dev_type != ["NA"])
      |> where([s], s.misc_tech_worked_with != ["NA"])
      |> select([s], %{
        dev_type: fragment("unnest(?)", s.dev_type),
        misc_tech_worked_with: fragment("unnest(?)", s.misc_tech_worked_with),
        id: s.id
      })

    devs_by_the_same_dev_type =
      query
      |> subquery()
      |> where([s], not is_nil(s.misc_tech_worked_with))
      |> where([s], s.dev_type in ^dev_type_list)
      |> select([s], %{misc_tech_worked_with: s.misc_tech_worked_with, id: s.id})

    devs_by_the_same_dev_type
    |> subquery()
    |> group_by([s], s.misc_tech_worked_with)
    |> select([s], %{
      misc_tech_worked_with: s.misc_tech_worked_with,
      number_of_developers: count(s.id)
    })
    |> order_by([s], desc: count(s.id))
  end
end
