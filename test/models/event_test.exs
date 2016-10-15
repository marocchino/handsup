defmodule Handsup.EventTest do
  use Handsup.ModelCase

  alias Handsup.User
  alias Handsup.Group
  alias Handsup.Event

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    {:ok, user} = User.changeset(%User{}, %{uid: "uid", provider: "google"})
                  |> Repo.insert
    {:ok, group} = user
                   |> build_assoc(:own_groups)
                   |> Group.changeset(%{name: "aaaa", name_eng: "aaaa"})
                   |> Repo.insert
    attrs = %{ name: "some content", group_id: group.id}
    changeset = Event.changeset(%Event{}, user, attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    user = %User{}
    changeset = Event.changeset(%Event{}, user, @invalid_attrs)
    refute changeset.valid?
  end
end
