defmodule Handsup.Group do
  @moduledoc """
  Group
  """
  use Handsup.Web, :model

  alias Handsup.User

  schema "groups" do
    field :name_eng, :string
    field :name, :string
    belongs_to :organizer, User
    many_to_many :users, User, join_through: "groups_users"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(map, map) :: map
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name_eng, :name])
    |> validate_required([:name_eng, :name])
    |> validate_format(:name_eng, ~r/^[\w_-]+$/i)
    |> unique_constraint(:name_eng)
  end
end

# TODO: Move it somewhere
defimpl Phoenix.Param, for: Handsup.Group do
  def to_param(%{name_eng: name_eng}) do
    name_eng
  end
end
