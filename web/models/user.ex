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
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uid, :provider, :nickname])
    |> validate_required([:uid, :provider])
    |> unique_constraint(:uid)
  end

  @doc """
  Find or Create user with passed oauth information.
  """
  def find_or_create(auth) do
    changes =
      %{uid: auth.uid, provider: auth.provider}
      |> Map.update(:provider, "google", &to_string/1)
    query = where(__MODULE__, uid: ^changes.uid, provider: ^changes.provider)
    user = Repo.one(query) || %__MODULE__{}
    user
    |> changeset(changes)
    |> Repo.insert_or_update
  end
end
