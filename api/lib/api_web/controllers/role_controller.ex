defmodule ApiWeb.RoleController do
  use ApiWeb, :controller

  alias Api.ApiContext
  alias Api.ApiContext.Role

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    role = ApiContext.list_role()
    render(conn, "index.json", role: role)
  end

  def create(conn, %{"role" => role_params}) do
    with {:ok, %Role{} = role} <- ApiContext.create_role(role_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.role_path(conn, :show, role))
      |> render("show.json", role: role)
    end
  end

  def show(conn, %{"id" => id}) do
    role = ApiContext.get_role!(id)
    render(conn, "show.json", role: role)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = ApiContext.get_role!(id)

    with {:ok, %Role{} = role} <- ApiContext.update_role(role, role_params) do
      render(conn, "show.json", role: role)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = ApiContext.get_role!(id)

    with {:ok, %Role{}} <- ApiContext.delete_role(role) do
      send_resp(conn, :no_content, "")
    end
  end
end
