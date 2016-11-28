defmodule Handsup.InsertHelper do
  alias Handsup.{Repo, User, Group, Event}

  def insert_user(attrs \\ []) do
    changes = Map.merge(%{
      uid: Ffaker.En.Lorem.characters(32),
      nickname: Ffaker.En.Name.name,
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

  def insert_event(user, group, attrs \\ []) do
    changes = Map.merge(%{
      group_id: group.id,
      name: "name"
    }, Map.new(attrs))

    %Event{}
    |> Event.changeset(user, changes)
    |> Repo.insert!
  end
end
