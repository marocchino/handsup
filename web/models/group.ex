defmodule Handsup.Group do
  use Handsup.Web, :model

  schema "groups" do
    field :name_eng, :string
    field :name, :string
    belongs_to :organizer, Handsup.Organizer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name_eng, :name])
    |> validate_required([:name_eng, :name])
    |> unique_constraint(:name_eng)
  end
end
