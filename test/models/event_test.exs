defmodule Handsup.EventTest do
  use Handsup.ModelCase

  alias Handsup.User
  alias Handsup.Group
  alias Handsup.Event
  alias Ffaker.En.Company
  alias Ffaker.En.Internet
  alias Ffaker.En.Venue

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    {:ok, user} = User.changeset(%User{}, %{uid: "uid", provider: "google"})
                  |> Repo.insert
    {:ok, group} = user
                   |> build_assoc(:own_groups)
                   |> Group.changeset(%{name: Company.name,
                                        name_eng: Internet.slug(nil, "-") })
                   |> Repo.insert
    attrs = %{name: Venue.name}
    changeset = Event.changeset(%Event{group_id: group.id}, user, attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    user = %User{}
    changeset = Event.changeset(%Event{}, user, @invalid_attrs)
    refute changeset.valid?
  end
end
