defmodule Handsup.Event do
  @moduledoc """
    Each event that owned by group
  """
  use Handsup.Web, :model

  alias Handsup.User
  alias Handsup.Group

  schema "events" do
    field :name, :string
    belongs_to :group, Group

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(map, map) :: map
  def changeset(struct, user, params \\ %{}) do
    struct
    |> cast(params, [:name, :group_id])
    |> validate_required([:name, :group_id])
    |> validate_owned(user)
  end

  @spec validate_owned(map, map) :: map
  defp validate_owned(changeset, user) do
    case User.owned?(user, changeset.changes) do
      true ->
        changeset
      _ ->
        add_error(changeset, :group_id, "You do not own this group")
    end
  end
end
