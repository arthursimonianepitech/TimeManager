defmodule Theme01.ThemeTest do
  use Theme01.DataCase

  alias Theme01.Theme

  describe "users" do
    alias Theme01.Theme.Users

    @valid_attrs %{email: "some email", username: "some username"}
    @update_attrs %{email: "some updated email", username: "some updated username"}
    @invalid_attrs %{email: nil, username: nil}

    def users_fixture(attrs \\ %{}) do
      {:ok, users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Theme.create_users()

      users
    end

    test "list_users/0 returns all users" do
      users = users_fixture()
      assert Theme.list_users() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Theme.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      assert {:ok, %Users{} = users} = Theme.create_users(@valid_attrs)
      assert users.email == "some email"
      assert users.username == "some username"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Theme.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      assert {:ok, %Users{} = users} = Theme.update_users(users, @update_attrs)
      assert users.email == "some updated email"
      assert users.username == "some updated username"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Theme.update_users(users, @invalid_attrs)
      assert users == Theme.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Theme.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Theme.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Theme.change_users(users)
    end
  end

  describe "workingtimes" do
    alias Theme01.Theme.WorkingTimes

    @valid_attrs %{end: ~N[2010-04-17 14:00:00], start: ~N[2010-04-17 14:00:00], workingTimeId: 42}
    @update_attrs %{end: ~N[2011-05-18 15:01:01], start: ~N[2011-05-18 15:01:01], workingTimeId: 43}
    @invalid_attrs %{end: nil, start: nil, workingTimeId: nil}

    def working_times_fixture(attrs \\ %{}) do
      {:ok, working_times} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Theme.create_working_times()

      working_times
    end

    test "list_workingtimes/0 returns all workingtimes" do
      working_times = working_times_fixture()
      assert Theme.list_workingtimes() == [working_times]
    end

    test "get_working_times!/1 returns the working_times with given id" do
      working_times = working_times_fixture()
      assert Theme.get_working_times!(working_times.id) == working_times
    end

    test "create_working_times/1 with valid data creates a working_times" do
      assert {:ok, %WorkingTimes{} = working_times} = Theme.create_working_times(@valid_attrs)
      assert working_times.end == ~N[2010-04-17 14:00:00]
      assert working_times.start == ~N[2010-04-17 14:00:00]
      assert working_times.workingTimeId == 42
    end

    test "create_working_times/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Theme.create_working_times(@invalid_attrs)
    end

    test "update_working_times/2 with valid data updates the working_times" do
      working_times = working_times_fixture()
      assert {:ok, %WorkingTimes{} = working_times} = Theme.update_working_times(working_times, @update_attrs)
      assert working_times.end == ~N[2011-05-18 15:01:01]
      assert working_times.start == ~N[2011-05-18 15:01:01]
      assert working_times.workingTimeId == 43
    end

    test "update_working_times/2 with invalid data returns error changeset" do
      working_times = working_times_fixture()
      assert {:error, %Ecto.Changeset{}} = Theme.update_working_times(working_times, @invalid_attrs)
      assert working_times == Theme.get_working_times!(working_times.id)
    end

    test "delete_working_times/1 deletes the working_times" do
      working_times = working_times_fixture()
      assert {:ok, %WorkingTimes{}} = Theme.delete_working_times(working_times)
      assert_raise Ecto.NoResultsError, fn -> Theme.get_working_times!(working_times.id) end
    end

    test "change_working_times/1 returns a working_times changeset" do
      working_times = working_times_fixture()
      assert %Ecto.Changeset{} = Theme.change_working_times(working_times)
    end
  end

  describe "clocks" do
    alias Theme01.Theme.Clocks

    @valid_attrs %{status: true, time: ~N[2010-04-17 14:00:00]}
    @update_attrs %{status: false, time: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{status: nil, time: nil}

    def clocks_fixture(attrs \\ %{}) do
      {:ok, clocks} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Theme.create_clocks()

      clocks
    end

    test "list_clocks/0 returns all clocks" do
      clocks = clocks_fixture()
      assert Theme.list_clocks() == [clocks]
    end

    test "get_clocks!/1 returns the clocks with given id" do
      clocks = clocks_fixture()
      assert Theme.get_clocks!(clocks.id) == clocks
    end

    test "create_clocks/1 with valid data creates a clocks" do
      assert {:ok, %Clocks{} = clocks} = Theme.create_clocks(@valid_attrs)
      assert clocks.status == true
      assert clocks.time == ~N[2010-04-17 14:00:00]
    end

    test "create_clocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Theme.create_clocks(@invalid_attrs)
    end

    test "update_clocks/2 with valid data updates the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{} = clocks} = Theme.update_clocks(clocks, @update_attrs)
      assert clocks.status == false
      assert clocks.time == ~N[2011-05-18 15:01:01]
    end

    test "update_clocks/2 with invalid data returns error changeset" do
      clocks = clocks_fixture()
      assert {:error, %Ecto.Changeset{}} = Theme.update_clocks(clocks, @invalid_attrs)
      assert clocks == Theme.get_clocks!(clocks.id)
    end

    test "delete_clocks/1 deletes the clocks" do
      clocks = clocks_fixture()
      assert {:ok, %Clocks{}} = Theme.delete_clocks(clocks)
      assert_raise Ecto.NoResultsError, fn -> Theme.get_clocks!(clocks.id) end
    end

    test "change_clocks/1 returns a clocks changeset" do
      clocks = clocks_fixture()
      assert %Ecto.Changeset{} = Theme.change_clocks(clocks)
    end
  end
end
