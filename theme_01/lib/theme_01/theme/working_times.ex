defmodule Theme01.Theme.WorkingTimes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    field :workingTimeId, :integer
    field :users, :id

    timestamps()
  end

  @doc false
  def changeset(working_times, attrs) do
    working_times
    |> cast(attrs, [:start, :end, :users, :workingTimeId])
    |> validate_required([:start, :end, :users, :workingTimeId])
  end
end
