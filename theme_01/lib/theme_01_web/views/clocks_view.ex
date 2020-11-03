defmodule Theme01Web.ClocksView do
  use Theme01Web, :view
  alias Theme01Web.ClocksView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClocksView, "clocks.json")}
  end

  def render("show.json", %{clocks: clocks}) do
    %{data: render_one(clocks, ClocksView, "clocks.json")}
  end

  def render("clocks.json", %{clocks: clocks}) do
    %{id: clocks.id,
      status: clocks.status,
      time: clocks.time,
      users: clocks.users
    }
  end
end
