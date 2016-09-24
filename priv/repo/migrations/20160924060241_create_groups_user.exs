defmodule Handsup.Repo.Migrations.CreateGroupsUser do
  use Ecto.Migration

  def change do
    create table(:groups_users) do
      add :user_id, references(:users, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps()
    end
    create index(:groups_users, [:user_id])
    create index(:groups_users, [:group_id])

  end
end
