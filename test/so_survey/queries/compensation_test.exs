defmodule SoSurvey.Queries.CompensationTest do
  use ExUnit.Case

  alias SoSurvey.Queries.Compensation
  alias SoSurvey.Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})
  end

  test "comp_by_dev_type_and_years_code_pro" do
    q =
      Repo.all(Compensation.comp_by_dev_type_and_years_code_pro(["Developer, full-stack"], 10))
      |> List.first()

    assert q.dev_type === "Developer, full-stack"
    assert round(q.compensation) === 148_257
  end

  test "comp_by_work_type" do
    q =
      Repo.all(Compensation.comp_by_dev_type_and_years_code_pro(["Developer, full-stack"], 10))
      |> List.first()

    assert q.dev_type === "Developer, full-stack"
    assert round(q.compensation) === 148_257
  end
end
