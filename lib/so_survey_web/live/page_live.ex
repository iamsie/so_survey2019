defmodule SoSurveyWeb.PageLive do
  use SoSurveyWeb, :live_view
  require Logger

  alias SoSurvey.Queries.MainPageForm
  alias SoSurvey.Queries.Education
  alias SoSurvey.Queries.Technology
  alias SoSurvey.Queries.Compensation
  alias SoSurvey.Repo

  def mount(_params, _session, socket) do
    dev_type_list = Repo.all(MainPageForm.list_dev_types())
    employment_variants = Repo.all(MainPageForm.list_employments_variants())
    countries = Repo.all(MainPageForm.list_countries())
    languages = Repo.all(MainPageForm.list_languages())
    genders = Repo.all(MainPageForm.list_genders())
    ed_levels = Repo.all(MainPageForm.list_ed_levels())

    {:ok,
     assign(socket,
       template: "index",
       dev_type_list: dev_type_list,
       employment_variants: employment_variants,
       countries: countries,
       languages_list: languages,
       genders: genders,
       ed_levels: ed_levels,
       dev_type: nil,
       employment_type: nil,
       country: nil,
       languages: nil,
       gender: nil,
       years_code: nil,
       years_code_pro: nil,
       age: nil,
       ed_level: nil,
       open_source_contributors: nil,
       ed_level: nil,
       undergrad_major: nil,
       ed_other: nil,
       db_worked_with: nil,
       platform_worked_with: nil,
       web_frame_worked_with: nil,
       other_techs_worked_with: nil,
       comp_by_dev_type_and_years_code_pro: nil,
       comp_by_work_type: nil,
       comp_by_dev_type_and_gender: nil,
       comp_by_ed_level_and_years_code_pro: nil,
       comp_by_country_and_lang_worked_with: nil
     )}
  end

  def render(%{template: "charts"} = assigns) do
    SoSurveyWeb.PageView.render("charts.html", assigns)
  end

  def render(assigns) do
    SoSurveyWeb.PageView.render("page.html", assigns)
  end

  def handle_event("dev_choice", %{"dev_info" => params}, socket) do
    Logger.info("Handle event Dev Choice")

    open_source_contributors =
      Repo.all(
        Education.contribute_to_open_source_by_years_code_pro_and_dev_type(
          String.to_integer(params["years_code_pro"])
        )
      )

    ed_level_by_the_same_dev_type =
      Repo.all(Education.degree_type_by_dev_type(params["dev_type"]))

    undergrad_major_by_the_same_dev_type =
      Repo.all(Education.undergrad_major_by_dev_type(params["dev_type"]))

    ed_other_by_the_same_dev_type = Repo.all(Education.ed_other_by_dev_type(params["dev_type"]))

    most_popular_db_by_dev_type =
      Repo.all(Technology.most_popular_db_by_dev_type(params["dev_type"]))

    most_popular_platform_by_dev_type =
      Repo.all(Technology.most_popular_platform_by_dev_type(params["dev_type"]))

    most_popular_web_frame_by_dev_type =
      Repo.all(Technology.most_popular_web_frame_by_dev_type(params["dev_type"]))

    other_popular_techs_worked_with_by_dev_type =
      Repo.all(Technology.other_popular_techs_by_dev_type(params["dev_type"]))

    comp_by_dev_type_and_years_code_pro =
      Repo.all(
        Compensation.comp_by_dev_type_and_years_code_pro(
          params["dev_type"],
          String.to_integer(params["years_code_pro"])
        )
      )
      |> Enum.map(fn %{compensation: fl, dev_type: str} ->
        %{compensation: round(fl), dev_type: str}
      end)

    comp_by_work_type =
      Repo.all(Compensation.comp_by_work_type(params["dev_type"]))
      |> Enum.map(fn %{compensation: fl, employment: str} ->
        %{compensation: round(fl), employment: str}
      end)

    comp_by_dev_type_and_gender =
      Repo.all(Compensation.comp_by_dev_type_and_gender(params["dev_type"]))
      |> Enum.map(fn %{compensation: fl, gender: str} ->
        %{compensation: round(fl), gender: str}
      end)

    comp_by_ed_level_and_years_code_pro =
      Repo.all(
        Compensation.comp_by_ed_level_and_years_code_pro(
          params["ed_level"],
          String.to_integer(params["years_code_pro"])
        )
      )

    comp_by_country_and_lang_worked_with =
      Repo.all(Compensation.comp_level_by_country_and_lang_worked_with(params["country"]))

    socket =
      socket
      |> assign(:template, "charts")
      |> assign(:open_source_contributors, open_source_contributors)
      |> assign(:ed_level, ed_level_by_the_same_dev_type)
      |> assign(:undergrad_major, undergrad_major_by_the_same_dev_type)
      |> assign(:ed_other, ed_other_by_the_same_dev_type)
      |> assign(:db_worked_with, most_popular_db_by_dev_type)
      |> assign(:platform_worked_with, most_popular_platform_by_dev_type)
      |> assign(:web_frame_worked_with, most_popular_web_frame_by_dev_type)
      |> assign(:other_techs_worked_with, other_popular_techs_worked_with_by_dev_type)
      |> assign(:comp_by_dev_type_and_years_code_pro, comp_by_dev_type_and_years_code_pro)
      |> assign(:comp_by_work_type, comp_by_work_type)
      |> assign(:comp_by_dev_type_and_gender, comp_by_dev_type_and_gender)
      |> assign(:comp_by_ed_level_and_years_code_pro, comp_by_ed_level_and_years_code_pro)
      |> assign(:comp_by_country_and_lang_worked_with, comp_by_country_and_lang_worked_with)

    {:noreply, socket}
  end

  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> assign(:template, "index")

    {:noreply, socket}
  end
end
