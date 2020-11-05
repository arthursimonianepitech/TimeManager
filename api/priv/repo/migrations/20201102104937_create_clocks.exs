defmodule Api.Repo.Migrations.CreateClocks do
  use Ecto.Migration

  def change do
    create table(:clocks) do
      add :status, :boolean, default: false, null: false
      add :time, :naive_datetime
      add :users, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:clocks, [:users])
  end
end
