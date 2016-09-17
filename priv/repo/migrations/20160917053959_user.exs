defmodule Handsup.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uid, :string, unique: true
      add :provider, :string
      add :nickname, :string
      timestamps
    end

    create unique_index(:users, [:provider, :uid],
                        name: :unique_provier_and_uid)
  end
end
