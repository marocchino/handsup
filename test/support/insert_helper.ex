defmodule Handsup.InsertHelper do
  alias Handsup.Repo
  alias Handsup.User
  alias Handsup.Group

  def insert_user(attrs \\ []) do
    changes = Map.merge(%{
      uid: "some_unique_id",
      nickname: "name",
      provider: "google"
    }, Map.new(attrs))

    %User{}
    |> User.changeset(changes)
    |> Repo.insert!
  end
  
  def insert_group(user, attrs \\ []) do
    changes = Map.merge(%{
      name: "name",
      name_eng: "name_eng"
    }, Map.new(attrs))

    %Group{organizer_id: user.id}
    |> Group.changeset(changes)
    |> Repo.insert!
  end
end
