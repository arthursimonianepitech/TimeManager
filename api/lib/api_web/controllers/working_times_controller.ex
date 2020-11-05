defmodule ApiWeb.WorkingTimesController do
  use ApiWeb, :controller

  alias Api.ApiContext
  alias Api.ApiContext.WorkingTimes

  action_fallback ApiWeb.FallbackController

  def show(conn, %{"id" => id}) do
    users = Guardian.Plug.current_resource(conn)
    working_times = ApiContext.get_working_times!(id)

    case user_can_access_working_time(users, working_times) do
      false ->
        {:error, "You can't access this working time."}

      true ->
        render(conn, "show.json", working_times: working_times)
    end
  end

  def show(conn, %{"start" => start, "end" => end_}) do
    users = Guardian.Plug.current_resource(conn)

    {:ok, start} = NaiveDateTime.from_iso8601(start)
    {:ok, end_} = NaiveDateTime.from_iso8601(end_)
    working_times = ApiContext.get_working_times_by_params(users.id, start, end_)
    render(conn, "index.json", workingtimes: working_times)
  end

  def show(conn, _params) do
    users = Guardian.Plug.current_resource(conn)
    working_times = ApiContext.get_working_times_by_user_id(users.id)
    render(conn, "index.json", workingtimes: working_times)
  end

  defp get_biggest_working_time_id_from_user(users) do
    # Get the maximum working time id.
    max_working_time_id = ApiContext.get_max_working_time_id_from_user_id(users.id)
    # If the working time id is null set to 1 otherwise + 1
    working_time_id = if is_nil(max_working_time_id), do: 1, else: max_working_time_id + 1
    working_time_id
  end

  def create(conn, %{"working_times" => working_times_params}) do
    users = Guardian.Plug.current_resource(conn)
    working_time_id = get_biggest_working_time_id_from_user(users)

    working_times_params = Map.put(working_times_params, "users", users.id)
    working_times_params = Map.put(working_times_params, "workingTimeId", working_time_id)

    with {:ok, %WorkingTimes{} = working_times} <-
           ApiContext.create_working_times(working_times_params) do
      conn
      |> put_status(:created)
      |> render("show.json", working_times: working_times)
    end
  end

  defp user_can_access_working_time(users, working_times) do
    users.id == working_times.users
  end

  def update(conn, %{"id" => id, "working_times" => working_times_params}) do
    users = Guardian.Plug.current_resource(conn)
    working_times = ApiContext.get_working_times!(id)

    case user_can_access_working_time(users, working_times) do
      false ->
        {:error, "You can't access this working time."}

      true ->
        with {:ok, %WorkingTimes{} = working_times} <-
               ApiContext.update_working_times(working_times, working_times_params) do
          render(conn, "show.json", working_times: working_times)
        end
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Guardian.Plug.current_resource(conn)
    working_times = ApiContext.get_working_times!(id)

    case user_can_access_working_time(users, working_times) do
      false ->
        {:error, "You can't access this working time."}

      true ->
        with {:ok, %WorkingTimes{}} <- ApiContext.delete_working_times(working_times) do
          send_resp(conn, :no_content, "")
        end
    end
  end
end
