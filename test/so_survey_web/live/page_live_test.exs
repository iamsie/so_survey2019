defmodule SoSurveyWeb.PageLiveTest do
  use SoSurveyWeb.ConnCase

  import Phoenix.LiveViewTest

  @params %{
    "years_code_pro" => "12",
    "dev_type" => ["Developer, full-stack"],
    "ed_level" => "Bachelor’s degree (BA, BS, B.Eng., etc.)",
    "country" => "Ukraine",
    "years_code" => "14",
    "gender" => "Woman",
    "languages" => ["JavaScript"],
    "employment_type" => "Employed part-time",
    "age" => "35"
  }

  test "disconnected and connected render", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<h5>My dev role(s) is:</h5>"

    {:ok, view, html} = live(conn)
  end

  test "handle event dev choice render charts template", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    render_submit(view, "dev_choice", %{"dev_info" => @params})

    assert html_response(conn, 200) =~
             "What Undergraduate Major do the developers of the same type have?"
  end
end
