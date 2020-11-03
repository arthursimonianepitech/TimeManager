defmodule Theme01Web.WorkingTimesView do
  use Theme01Web, :view
  alias Theme01Web.WorkingTimesView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingTimesView, "working_times.json")}
  end

  def render("show.json", %{working_times: working_times}) do
    %{data: render_one(working_times, WorkingTimesView, "working_times.json")}
  end

  def render("working_times.json", %{working_times: working_times}) do
    %{id: working_times.id,
      start: working_times.start,
      end: working_times.end,
      workingTimeId: working_times.workingTimeId,
      users: working_times.users
    }
  end
end
