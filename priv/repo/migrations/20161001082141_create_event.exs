defmodule Handsup.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps()
    end
    create index(:events, [:group_id])

  end
end
