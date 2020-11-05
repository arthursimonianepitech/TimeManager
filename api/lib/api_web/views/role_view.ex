defmodule ApiWeb.RoleView do
  use ApiWeb, :view
  alias ApiWeb.RoleView

  def render("index.json", %{role: role}) do
    %{data: render_many(role, RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{id: role.id,
      name: role.name}
  end
end
