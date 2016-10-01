defmodule Handsup.Event do
  @moduledoc """
    Each event that owned by group
  """
  use Handsup.Web, :model

  schema "events" do
    field :name, :string
    belongs_to :group, Handsup.Group

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
