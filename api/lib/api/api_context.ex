defmodule Api.ApiContext do
  @moduledoc """
  The ApiContext context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.ApiContext.Role
  import Bcrypt, only: [verify_pass: 2]
  alias Api.Guardian

  @doc """
  Returns the list of role.

  ## Examples

      iex> list_role()
      [%Role{}, ...]

  """
  def list_role do
    Repo.all(Role)
  end

  @doc """
  Gets a single role.

  Raises `Ecto.NoResultsError` if the Role does not exist.

  ## Examples

      iex> get_role!(123)
      %Role{}

      iex> get_role!(456)
      ** (Ecto.NoResultsError)

  """
  def get_role!(id), do: Repo.get!(Role, id)

  def get_role_by_name(name), do: Repo.get_by(Role, name: name)

  @doc """
  Creates a role.

  ## Examples

      iex> create_role(%{field: value})
      {:ok, %Role{}}

      iex> create_role(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a role.

  ## Examples

      iex> update_role(role, %{field: new_value})
      {:ok, %Role{}}

      iex> update_role(role, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_role(%Role{} = role, attrs) do
    role
    |> Role.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a role.

  ## Examples

      iex> delete_role(role)
      {:ok, %Role{}}

      iex> delete_role(role)
      {:error, %Ecto.Changeset{}}

  """
  def delete_role(%Role{} = role) do
    Repo.delete(role)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking role changes.

  ## Examples

      iex> change_role(role)
      %Ecto.Changeset{data: %Role{}}

  """
  def change_role(%Role{} = role, attrs \\ %{}) do
    Role.changeset(role, attrs)
  end

  alias Api.ApiContext.Users

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%Users{}, ...]

  """
  def list_users do
    Repo.all(Users)
  end

  @doc """
  Gets a single users.

  Raises `Ecto.NoResultsError` if the Users does not exist.

  ## Examples

      iex> get_users!(123)
      %Users{}

      iex> get_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_users!(id), do: Repo.get!(Users, id)

  def get_users_by_params!(username, email),
    do: Repo.get_by!(Users, username: username, email: email)

  @doc """
  Creates a users.

  ## Examples

      iex> create_users(%{field: value})
      {:ok, %Users{}}

      iex> create_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_users(attrs \\ %{}) do
    %Users{}
    |> Users.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a users.

  ## Examples

      iex> update_users(users, %{field: new_value})
      {:ok, %Users{}}

      iex> update_users(users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_users(%Users{} = users, attrs) do
    users
    |> Users.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a users.

  ## Examples

      iex> delete_users(users)
      {:ok, %Users{}}

      iex> delete_users(users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_users(%Users{} = users) do
    Repo.delete(users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking users changes.

  ## Examples

      iex> change_users(users)
      %Ecto.Changeset{data: %Users{}}

  """
  def change_users(%Users{} = users, attrs \\ %{}) do
    Users.changeset(users, attrs)
  end

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, users} ->
        Guardian.encode_and_sign(users)

      _ ->
        {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, users} <- get_by_email(email),
         do: verify_password(password, users)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(Users, email: email) do
      nil ->
        {:error, "Login error."}

      users ->
        {:ok, users}
    end
  end

  defp verify_password(password, %Users{} = users) when is_binary(password) do
    if verify_pass(password, users.password_hash) do
      {:ok, users}
    else
      {:error, :invalid_password}
    end
  end

  alias Api.ApiContext.WorkingTimes

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%WorkingTimes{}, ...]

  """
  def list_workingtimes do
    Repo.all(WorkingTimes)
  end

  @doc """
  Gets a single working_times.

  Raises `Ecto.NoResultsError` if the Working times does not exist.

  ## Examples

      iex> get_working_times!(123)
      %WorkingTimes{}

      iex> get_working_times!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_times!(id), do: Repo.get!(WorkingTimes, id)

  @doc """
  Gets a single working_times, from userId and workingTimeId.

  Raises `Ecto.NoResultsError` if the Working times does not exist.

  ## Examples

      iex> get_working_times!(1, 12)
      %WorkingTimes{}

      iex> get_working_times!(1, 404)
      ** (Ecto.NoResultsError)

  """
  def get_working_times!(userId, workingTimeId),
    do: Repo.get_by!(WorkingTimes, users: userId, workingTimeId: workingTimeId)

  @doc """
  Gets all working_times by userId.

  Raises `Ecto.NoResultsError` if the Working times does not exist.
  """

  # def get_working_times_by_user_id(userId), do: Repo.all(WorkingTimes, users: userId)
  def get_working_times_by_user_id(userId) do
    recording_query =
      from(
        w in WorkingTimes,
        where: w.users == ^userId,
        select: w
      )

    Repo.all(recording_query)
  end

  # Repo.all(WorkingTimes, users: userId)

  @doc """
  Gets a single working_times by a userId, a start and an end.

  Raises `Ecto.NoResultsError` if the Working times does not exist.
  """
  def get_working_times_by_params(userId, start, end_) do
    recording_query =
      from(
        w in WorkingTimes,
        where: w.users == ^userId and w.start >= ^start and w.end <= ^end_,
        select: w
      )

    Repo.all(recording_query)
  end

  @doc """
  Gets the highest id of working_times for a given userId.

  Raises `Ecto.NoResultsError` if the Working times does not exist.
  """
  def get_max_working_time_id_from_user_id(userId) do
    query = from(w in "working_time_view", select: w.workingTimeId, where: w.users == ^userId)
    Repo.one(query)
  end

  @doc """
  Create the view for working_time, if it doesn't exist.
  """
  def create_view_if_not_exists() do
    query = "CREATE OR REPLACE VIEW working_time_view AS
    SELECT t1.\"users\", t1.\"workingTimeId\" FROM workingtimes t1
    JOIN (
      SELECT workingtimes.\"users\", MAX(workingtimes.\"workingTimeId\") AS \"workingTimeId\"
      FROM workingtimes
      GROUP BY workingtimes.\"users\") t2
    ON t1.\"users\" = t2.\"users\" AND t1.\"workingTimeId\" = t2.\"workingTimeId\";"
    Repo.query(query)
  end

  @doc """
  Creates a working_times.

  ## Examples

      iex> create_working_times(%{field: value})
      {:ok, %WorkingTimes{}}

      iex> create_working_times(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_times(attrs \\ %{}) do
    %WorkingTimes{}
    |> WorkingTimes.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a working_times.

  ## Examples

      iex> update_working_times(working_times, %{field: new_value})
      {:ok, %WorkingTimes{}}

      iex> update_working_times(working_times, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_times(%WorkingTimes{} = working_times, attrs) do
    working_times
    |> WorkingTimes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_times.

  ## Examples

      iex> delete_working_times(working_times)
      {:ok, %WorkingTimes{}}

      iex> delete_working_times(working_times)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_times(%WorkingTimes{} = working_times) do
    Repo.delete(working_times)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_times changes.

  ## Examples

      iex> change_working_times(working_times)
      %Ecto.Changeset{data: %WorkingTimes{}}

  """
  def change_working_times(%WorkingTimes{} = working_times, attrs \\ %{}) do
    WorkingTimes.changeset(working_times, attrs)
  end

  alias Api.ApiContext.Clocks

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clocks{}, ...]

  """
  def list_clocks do
    Repo.all(Clocks)
  end

  @doc """
  Gets a single clocks.

  Raises `Ecto.NoResultsError` if the Clocks does not exist.

  ## Examples

      iex> get_clocks!(123)
      %Clocks{}

      iex> get_clocks!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clocks!(id), do: Repo.get!(Clocks, id)

  @doc """
  Gets all clocks by a userId.

  Raises `Ecto.NoResultsError` if the Clocks does not exist.
  """
  def get_clocks_by_user_id(user_ids) do
    recording_query =
      from(
        r in Clocks,
        where: r.users == ^user_ids,
        select: r
      )

    Repo.all(recording_query)
  end

  @doc """
  Creates a clocks.

  ## Examples

      iex> create_clocks(%{field: value})
      {:ok, %Clocks{}}

      iex> create_clocks(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clocks(attrs \\ %{}) do
    %Clocks{}
    |> Clocks.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clocks.

  ## Examples

      iex> update_clocks(clocks, %{field: new_value})
      {:ok, %Clocks{}}

      iex> update_clocks(clocks, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clocks(%Clocks{} = clocks, attrs) do
    clocks
    |> Clocks.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clocks.

  ## Examples

      iex> delete_clocks(clocks)
      {:ok, %Clocks{}}

      iex> delete_clocks(clocks)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clocks(%Clocks{} = clocks) do
    Repo.delete(clocks)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clocks changes.

  ## Examples

      iex> change_clocks(clocks)
      %Ecto.Changeset{data: %Clocks{}}

  """
  def change_clocks(%Clocks{} = clocks, attrs \\ %{}) do
    Clocks.changeset(clocks, attrs)
  end
end
