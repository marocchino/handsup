defmodule Handsup.Repo.Migrations.CreateGroup do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name_eng, :string
      add :name, :string
      add :organizer_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create unique_index(:groups, [:name_eng])
    create index(:groups, [:organizer_id])

  end
end
