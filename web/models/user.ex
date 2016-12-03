defmodule Handsup.User do
  @moduledoc """
    OAuth user
  """

  use Handsup.Web, :model

  alias Handsup.Repo
  alias Handsup.Group

  schema "users" do
    field :uid, :string
    field :provider, :string
    field :nickname, :string
    has_many :own_groups, Group, foreign_key: :organizer_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(map, map) :: map
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uid, :provider, :nickname])
    |> validate_required([:uid, :provider])
    |> unique_constraint(:uid)
  end

  @doc """
  Return true if event is from a group owned by user
  """
  @spec owned?(map, number) :: boolean
  def owned?(user, group_id) do
    if Repo.get(assoc(user, :own_groups), group_id) do
      true
    else
      false
    end
  end

  @doc """
  Find or Create user with passed oauth information.
  """
  @spec find_or_create(map) :: map
  def find_or_create(%{uid: uid, provider: :google}) do
    changes =
      %{uid: uid, provider: "google"}
    query = where(__MODULE__, uid: ^changes.uid, provider: ^changes.provider)
    user = Repo.one(query) || %__MODULE__{}
    user
    |> changeset(changes)
    |> Repo.insert_or_update
  end

  def find_or_create(%{provider: provider}) do
    {:error, "Unknown Provider: #{provider}"}
  end
end
