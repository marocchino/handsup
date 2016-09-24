defmodule Handsup.TestHelpers do
  alias Handsup.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      uid: "some_unique_id",
      nickname: "name",
      provider: "google"
    }, attrs)

    %Handsup.User{}
    |> Handsup.User.changeset(changes)
    |> Repo.insert!
  end
  
  def insert_group(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "name",
      name_eng: "name_eng"
    }, attrs)

    %Handsup.Group{}
    |> Handsup.Group.changeset(changes)
    |> Repo.insert!
  end
end
