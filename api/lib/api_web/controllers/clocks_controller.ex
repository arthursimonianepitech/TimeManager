defmodule ApiWeb.ClocksController do
  use ApiWeb, :controller

  alias Api.ApiContext
  alias Api.ApiContext.Clocks

  action_fallback ApiWeb.FallbackController

  # def index(conn, _params) do
  #   clocks = ApiContext.list_clocks()
  #   render(conn, "index.json", clocks: clocks)
  # end

  def create(conn, %{"clocks" => clocks_params}) do
    users = Guardian.Plug.current_resource(conn)
    clocks_params = Map.put(clocks_params, "users", users.id)

    with {:ok, %Clocks{} = clocks} <- ApiContext.create_clocks(clocks_params) do
      conn
      |> put_status(:created)
      |> render("show.json", clocks: clocks)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Guardian.Plug.current_resource(conn)
    clocks = ApiContext.get_clocks!(id)

    case user_can_access_clock(users, clocks) do
      false ->
        {:error, "You can't access this clock."}

      true ->
        render(conn, "show.json", clocks: clocks)
    end
  end

  def show(conn, _params) do
    users = Guardian.Plug.current_resource(conn)
    clocks = ApiContext.get_clocks_by_user_id(users.id)
    render(conn, "index.json", clocks: clocks)
  end

  defp user_can_access_clock(users, clocks) do
    users.id == clocks.users
  end
end
