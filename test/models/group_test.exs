defmodule Handsup.GroupTest do
  use Handsup.ModelCase

  alias Handsup.Group
  alias Ffaker.En.Company
  alias Ffaker.En.Internet

  @valid_attrs %{name: Company.name, name_eng: Internet.slug(nil, "-") }
  @invalid_attrs %{}
  @invalid_group_eng %{name: Company.name, name_eng: "group eng"}

  test "changeset with valid attributes" do
    changeset = Group.changeset(%Group{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Group.changeset(%Group{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with invalid format of group_eng" do
    changeset = Group.changeset(%Group{}, @invalid_group_eng)
    refute changeset.valid?
  end
end
