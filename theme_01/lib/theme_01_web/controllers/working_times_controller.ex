defmodule Theme01Web.WorkingTimesController do
  use Theme01Web, :controller

  alias Theme01.Theme
  alias Theme01.Theme.WorkingTimes

  action_fallback Theme01Web.FallbackController

  def index(conn, _params) do
    workingtimes = Theme.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def show(conn, %{"id" => userId, "start" => start, "end" => end_}) do
    {:ok, start} = NaiveDateTime.from_iso8601(start)
    {:ok, end_} = NaiveDateTime.from_iso8601(end_)
    working_times = Theme.get_working_times_by_params(userId, start, end_)
    render(conn, "index.json", workingtimes: working_times)
  end

  def show(conn, %{"userID" => userId, "workingtimeID" => workingTimeId}) do
    working_times = Theme.get_working_times!(userId, workingTimeId)
    render(conn, "show.json", working_times: working_times)
  end

  def create(conn, %{"userID" => userId,"working_times" => working_times_params}) do
    working_times_params = Map.put(working_times_params, "users", userId)

    # Crete The View working_time_view if it doesn't exist
    Theme.create_view_if_not_exists()
    # Get the maximum working time id.
    max_working_time_id_from_user_id = Theme.get_max_working_time_id_from_user_id(userId)
    # If the working time id is null set to 1 otherwise + 1
    working_time_id = if is_nil(max_working_time_id_from_user_id), do: 1, else: max_working_time_id_from_user_id + 1

    working_times_params = Map.put(working_times_params, "workingTimeId", working_time_id)

    with {:ok, %WorkingTimes{} = working_times} <- Theme.create_working_times(working_times_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_times_path(conn, :show, working_times))
      |> render("show.json", working_times: working_times)
    end
  end

  def update(conn, %{"id" => id, "working_times" => working_times_params}) do
    working_times = Theme.get_working_times!(id)

    with {:ok, %WorkingTimes{} = working_times} <- Theme.update_working_times(working_times, working_times_params) do
      render(conn, "show.json", working_times: working_times)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_times = Theme.get_working_times!(id)

    with {:ok, %WorkingTimes{}} <- Theme.delete_working_times(working_times) do
      send_resp(conn, :no_content, "")
    end
  end
end
