defmodule Theme01Web.ClocksController do
  use Theme01Web, :controller

  alias Theme01.Theme
  alias Theme01.Theme.Clocks

  action_fallback Theme01Web.FallbackController

  def index(conn, _params) do
    clocks = Theme.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"userID" => userId, "clocks" => clocks_params}) do
    clocks_params = Map.put(clocks_params, "users", userId)

    with {:ok, %Clocks{} = clocks} <- Theme.create_clocks(clocks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clocks_path(conn, :show, clocks))
      |> render("show.json", clocks: clocks)
    end
  end

  def show(conn, %{"id" => userId}) do
    clocks = Theme.get_clocks_by_user_id(userId)
    render(conn, "index.json", clocks: clocks)
  end

end
