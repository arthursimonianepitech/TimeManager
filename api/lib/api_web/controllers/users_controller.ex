defmodule ApiWeb.UsersController do
  use ApiWeb, :controller

  alias Api.Guardian
  alias Api.ApiContext
  alias Api.ApiContext.Users

  action_fallback(ApiWeb.FallbackController)

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case ApiContext.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)

      _ ->
        {:error, :unauthorized}
    end
  end

  def create(conn, %{"user" => users_params}) do
    with {:ok, %Users{} = users} <- ApiContext.create_users(users_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(users) do
      conn |> render("jwt.json", jwt: token)
    end
  end

  def show(conn, _params) do
    users = Guardian.Plug.current_resource(conn)
    conn |> render("users.json", users: users)
  end

  def delete(conn, _params) do
    users = Guardian.Plug.current_resource(conn)

    with {:ok, %Users{}} <- ApiContext.delete_users(users) do
      send_resp(conn, :no_content, "")
    end
  end

  def update(conn, %{"user" => users_params}) do
    users = Guardian.Plug.current_resource(conn)

    with {:ok, %Users{} = users} <- ApiContext.update_users(users, users_params) do
      render(conn, "show.json", users: users)
    end
  end
end
