defmodule Theme01.Theme.Clocks do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime
    field :users, :id

    timestamps()
  end

  @doc false
  def changeset(clocks, attrs) do
    clocks
    |> cast(attrs, [:status, :time,  :users])
    |> validate_required([:status, :time, :users])
  end
end
