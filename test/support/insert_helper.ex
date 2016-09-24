defmodule Handsup.InsertHelper do
  alias Handsup.Repo

  def insert_user(attrs \\ []) do
    changes = Map.merge(%{
      uid: "some_unique_id",
      nickname: "name",
      provider: "google"
    }, Map.new(attrs))

    %Handsup.User{}
    |> Handsup.User.changeset(changes)
    |> Repo.insert!
  end
  
  def insert_group(attrs \\ []) do
    changes = Map.merge(%{
      name: "name",
      name_eng: "name_eng"
    }, Map.new(attrs))

    %Handsup.Group{}
    |> Handsup.Group.changeset(changes)
    |> Repo.insert!
  end
end
