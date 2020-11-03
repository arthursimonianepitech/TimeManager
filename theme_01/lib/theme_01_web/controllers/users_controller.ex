defmodule Theme01Web.UsersController do
  use Theme01Web, :controller

  alias Theme01.Theme
  alias Theme01.Theme.Users

  action_fallback Theme01Web.FallbackController

  def index(conn, %{"username" => username, "email" => email}) do
    users = Theme.get_users_by_params!(username, email)
    render(conn, "show.json", users: users)
  end

  def index(conn, _params) do
    users = Theme.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => users_params}) do
    with {:ok, %Users{} = users} <- Theme.create_users(users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.users_path(conn, :show, users))
      |> render("show.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Theme.get_users!(id)
    render(conn, "show.json", users: users)
  end

  def update(conn, %{"id" => id, "user" => users_params}) do
    users = Theme.get_users!(id)
    with {:ok, %Users{} = users} <- Theme.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Theme.get_users!(id)

    with {:ok, %Users{}} <- Theme.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end
end
