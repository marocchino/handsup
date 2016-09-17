defmodule Handsup.UserTest do
  use Handsup.ModelCase

  alias Handsup.User

  @valid_attrs %{nickname: "some content",
                 provider: "some content",
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
    assert auth.uid == actual.uid
    assert to_string(auth.provider) == actual.provider
  end

  test "find_or_create return {:error, _reason}" do
    auth = %{uid: "", provider: :google}
    {status, _reason} = User.find_or_create(auth)

    assert status == :error
  end
end
