defmodule SoSurvey.SurveyResults do
  use Ecto.Schema

  schema "so_survey_results_2019" do
    field :main_branch, :string
    field :open_sourcer, :string
    field :employment, :string
    field :country, :string
    field :student, :string
    field :ed_level, :string
    field :undergrad_major, :string
    field :work_remote, :string
    field :edu_other, {:array, :string}
    field :dev_type, {:array, :string}
    field :years_code, :integer
    field :age1st_code, :integer
    field :years_code_pro, :integer
    field :job_factors, {:array, :string}
    field :converted_comp, :float
    field :work_week_hrs, :float
    field :imp_syn, :string
    field :language_worked_with, {:array, :string}
    field :language_desire_next_year, {:array, :string}
    field :database_worked_with, {:array, :string}
    field :database_desire_next_year, {:array, :string}
    field :platform_worked_with, {:array, :string}
    field :platform_desire_next_year, {:array, :string}
    field :web_frame_worked_with, {:array, :string}
    field :web_frame_desire_next_year, {:array, :string}
    field :misc_tech_worked_with, {:array, :string}
    field :misc_tech_desire_next_year, {:array, :string}
    field :dev_environ, {:array, :string}
    field :age, :float
    field :gender, :string
  end
end
