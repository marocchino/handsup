defmodule Handsup.UserTest do
  use Handsup.ModelCase

  alias Handsup.User
  alias Handsup.Group
  alias Ffaker.En.Internet

  @valid_attrs %{nickname: Internet.user_name,
                 provider: "google",
                 uid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "owned? without group_id" do
    user = %User{id: 1}
    event = %{id: 1}
    refute User.owned?(user, event)
  end

  test "owned? with group_id that user not owned" do
    user = %User{id: 1}
    event = %{id: 1, group_id: 1}
    refute User.owned?(user, event)
  end

  test "owned? with group_id that user owned" do
    {:ok, user} = User.changeset(%User{}, %{uid: "uid", provider: "google"})
                  |> Repo.insert
    {:ok, group} = user
                   |> build_assoc(:own_groups)
                   |> Group.changeset(%{name: "aaaa", name_eng: "aaaa"})
                   |> Repo.insert
    event = %{id: 1, group_id: group.id}
    assert User.owned?(user, event)
  end

  test "find_or_create return {:ok, user} with exist user" do
    auth = %{uid: "uid", provider: :google}
    user_attrs = %{uid: "uid", provider: "google"}
    changeset = User.changeset(%User{}, user_attrs)
    {:ok, expected} = Repo.insert(changeset)

    {status, actual} = User.find_or_create(auth)

    assert status == :ok
    assert expected == actual
  end

  test "find_or_create return {:ok, user} with new user" do
    auth = %{uid: "uid", provider: :google}
    {status, actual} = User.find_or_create(auth)

    assert status == :ok
    assert actual.uid == "uid"
    assert actual.provider == "google"
  end

  test "find_or_create return {:error, _reason}" do
    auth = %{uid: "", provider: :google}
    {status, _} = User.find_or_create(auth)

    assert status == :error
  end
end
